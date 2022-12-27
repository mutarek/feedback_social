import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:als_frontend/data/model/response/calling/call_model.dart';
import 'package:als_frontend/data/model/response/calling/user_calling_model.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/theme/enum.dart';
import 'package:als_frontend/util/theme/random_id.dart';
import 'package:just_audio/just_audio.dart';

class AgoraCallProvider with ChangeNotifier{
  int remoteUserId = 0;
  RtcEngine? _engine;
  bool isFront = false;
  bool reConnectingRemoteView = false;
  bool videoPaused = false;

  bool mutedAudio = false;

  bool mutedVideo = false;

  bool switchMainView = false;

  bool remoteJoined = false;
  final player = AudioPlayer();
  late String localCallId;
  UserModel? opponent;
  //Initialize All The Setup For Agora Video Call

  setIncomingCallId(int id) {
    // callId = id;
  }
  clear() {
    isFront = false;
    reConnectingRemoteView = false;
    videoPaused = false;
    mutedAudio = false;
    mutedVideo = false;
    switchMainView = false;
    remoteJoined = false;

  }

  makeCallRequest({required Call call}) async {
    opponent = call.opponent;
    localCallId = randomId();

    // getIt<SocketManager>().emit(
    //     SocketConstants.callCreate,
    //     ({
    //       CallArgParams.senderId: getIt<UserProfileManager>().user!.id,
    //       CallArgParams.receiverId: call.opponent.id,
    //       CallArgParams.callType: call.callType,
    //       CallArgParams.localCallId: localCallId,
    //       // CallArgParams.channelName: channelName
    //     }));
  }
  Future<void> initializeCalling({
    required Call call,
  }) async {
    if (AppConstant.agoraApiKey.isEmpty) {

    notifyListeners();
      return;
    }
    Future.delayed(Duration.zero, () async {
      await _initAgoraRtcEngine(
          callType:
          call.callType == 1 ? AgoraCallType.audio : AgoraCallType.video);
      _addAgoraEventHandlers();
      var configuration = VideoEncoderConfiguration();
      configuration.dimensions =
      const VideoDimensions(width: 1920, height: 1080);
      configuration.orientationMode = VideoOutputOrientationMode.Adaptative;
      await _engine!.setVideoEncoderConfiguration(configuration);
      await _engine!.leaveChannel();

      // await _engine!.joinChannel(call.token, call.channelName, null,
      //     getIt<UserProfileManager>().user!.id, token: '');

      if (call.callType == 1) {
        // Get.to(() => AudioCallingScreen(call: call));
      } else {
        // Get.to(() => VideoCallingScreen(call: call));
      }
    notifyListeners();
    });
  }

  //Initialize Agora RTC Engine
  Future<void> _initAgoraRtcEngine({required AgoraCallType callType}) async {
    _engine = await RtcEngine.create(AppConstant.agoraApiKey);
    if (callType == AgoraCallType.video) {
      await _engine!.enableVideo();
    }
  }

  //Switch Camera
  onToggleCamera() {
    _engine!.switchCamera().then((value) {
      isFront = !isFront;
      notifyListeners();
    }).catchError((err) {});
  }

  void toggleMainView() {
    switchMainView = !switchMainView;
    notifyListeners();
  }

  //Audio On / Off
  void onToggleMuteAudio() {
    mutedAudio = !mutedAudio;
    _engine!.muteLocalAudioStream(mutedAudio);
    notifyListeners();
  }

  //Video On / Off
  void onToggleMuteVideo() {
    mutedVideo = !mutedVideo;
    _engine!.muteLocalVideoStream(mutedVideo);
    notifyListeners();
  }

  //Agora Events Handler To Implement Ui/UX Based On Your Requirements
  void _addAgoraEventHandlers() {
    _engine!.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        // final info = 'onError:$code ${code.index}';
        // print(info);
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        // final info = 'onJoinChannel: $channel, uid: $uid';
        // print(info);
      },
      leaveChannel: (stats) {
        // print('onLeaveChannel');
      },
      userJoined: (uid, elapsed) {
        // final info = 'userJoined: $uid';
        remoteJoined = true;
        remoteUserId = uid;
        notifyListeners();
      },
      userOffline: (uid, elapsed) async {
        if (elapsed == UserOfflineReason.Dropped) {
          // Wakelock.disable();
        } else {
          // final info = 'userOffline: $uid';
          remoteUserId = 0;
         notifyListeners();
          // _timerKey.currentState?.cancelTimer();
        }
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        // final info = 'firstRemoteVideo: $uid ${width}x $height';
      },
      connectionStateChanged: (type, reason) async {
        // print('connectionStateChanged');
        if (type == ConnectionStateType.Connected) {
          reConnectingRemoteView = false;
        } else if (type == ConnectionStateType.Reconnecting) {
          reConnectingRemoteView = true;
        }
      },
      remoteVideoStats: (remoteVideoStats) {
        if (remoteVideoStats.receivedBitrate == 0) {
          videoPaused = true;
        } else {
          videoPaused = false;
        }
      },
    ));
  }

  // call

  callStatusUpdateReceived(Map<String, dynamic> updatedData) {
    int status = updatedData['status'];

    // callId = 0;
    Call call = Call(
        uuid: updatedData['uuid'],
        channelName: '',
        isOutGoing: false,
        opponent: UserModel(),
        token: '',
        callType: 0,
        callId: updatedData['id']);

    if (status == 5 || status == 2) {
      if (Platform.isIOS) {
        // getIt<VoipController>().endCall(call);
      }
      // endCall(call);
    }
  }

  outgoingCallConfirmationReceived(Map<String, dynamic> updatedData) async{
    String uuid = updatedData['uuid'];
    int id = updatedData['id'];
    String localCallId = updatedData['localCallId'];
    var agoraToken = updatedData['token'];
    var channelName = updatedData['channelName'];
    int callType = updatedData['callType'];

    Call call = Call(
        uuid: uuid,
        channelName: channelName!,
        isOutGoing: true,
        opponent: opponent!,
        token: agoraToken!,
        callType: callType,
        callId: id);

    if (this.localCallId == localCallId) {
      // callId = id;
      initializeCalling(call: call);
      if (Platform.isIOS) {
        // getIt<VoipController>().outGoingCall(call);
      }
      await player.setAsset('assets/ringtone.mp3');
      player.play();
    }
  }

  incomingCallReceived(Map<String, dynamic> updatedData) {
    // int id = updatedData['id'];
    int callType = updatedData['callType'];
    String userImage = updatedData['userImage'];
    String username = updatedData['username'];
    int callerId = updatedData['callerId'];
    // String channelName = updatedData['channelName'];
    // String agoraToken = updatedData['token'];

    // callId = id;

    UserModel opponent = UserModel();
    opponent.id = callerId;
    opponent.userName = username;
    opponent.picture = userImage;

    if (callType == 1) {
      // audio call
      // Get.to(() =>
      //     AudioCallingScreen(
      //         opponent: opponent,
      //         channelName: channelName,
      //         token: agoraToken,
      //         isOutGoing: false //widget.isForOutGoing,
      //     ));
    } else {
      // video call
      // Call call = Call(
      //     callId: id,
      //     channelName: channelName,
      //     isOutGoing: false,
      //     opponent: opponent,
      //     callType: callType,
      //     token: agoraToken);
      // Get.to(() => VideoCallingScreen(
      //       call: call,
      //     ));
    }
  }

  // void acceptCall({required Call call}) async {
  //   // getIt<SocketManager>().emit(SocketConstants.onAcceptCall, {
  //   //   'uuid': call.uuid,
  //   //   'userId': getIt<UserProfileManager>().user!.id,
  //   //   'status': 4,
  //   //   'channelName': call.channelName
  //   });

  //   //Todo: this need to be checked
  //   remoteUserId.value = call.opponent.id;
  //   remoteJoined.value = true;
  //   initializeCalling(
  //     call: call,
  //   );
  //   player.stop();
  // }
  //
  // //Use This Method To End Call
  // void endCall(Call call) async {
  //   player.stop();
  //   if (remoteJoined.value == true) {
  //     _engine?.leaveChannel();
  //     _engine?.destroy();
  //
  //     clear();
  //   }
  //   // callId = 0;
  //   remoteJoined = false;
  //   // Get.back();
  //
  //   InterstitialAds().show();
  // }
  //
  // void onCallEnd(Call call) async {
  //   player.stop();
  //
  //   if (remoteJoined.value == true) {
  //     if (Platform.isAndroid) {
  //       endCall(call);
  //       Get.back();
  //     }
  //     getIt<SocketManager>().emit(SocketConstants.onCompleteCall, {
  //       'uuid': call.uuid,
  //       'userId': getIt<UserProfileManager>().user!.id,
  //       'status': 5,
  //       // 'channelName': call.channelName
  //     });
  //   } else {
  //     if (Platform.isAndroid) {
  //       endCall(call);
  //       notifyListeners();
  //       // Get.back();
  //     }
  //     getIt<SocketManager>().emit(SocketConstants.onRejectCall, {
  //       'uuid': call.uuid,
  //       'userId': getIt<UserProfileManager>().user!.id,
  //       'status': 2
  //     });
  //   }
  //   if (Platform.isIOS) {
  //     getIt<VoipController>().endCall(call);
  //   }
  // }
  //
  // void declineCall({required Call call}) async {
  //   getIt<SocketManager>().emit(SocketConstants.onRejectCall, {
  //     'uuid': call.uuid,
  //     'userId': getIt<UserProfileManager>().user!.id,
  //     'status': 2
  //   });
  //   if (Platform.isIOS) {
  //     getIt<VoipController>().endCall(call);
  //   }
  //   // callId = 0;
  //   remoteJoined.value = false;
  //   Get.back();
  // }
  //
  // void timeOutCall(Call call) async {
  //   getIt<SocketManager>().emit(SocketConstants.onNotAnswered, {
  //     'uuid': call.uuid,
  //     'userId': 2,// input user id
  //     'status': 3
  //   });
  //   // if (Platform.isIOS) {
  //   //   getIt<VoipController>().endCall(call);
  //   // }
  //   // callId = 0;
  //   remoteJoined = false;
  //   notifyListeners();
  //   // Get.back();
  // }
}