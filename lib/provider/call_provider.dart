import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:als_frontend/screens/chat/chats_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/secret.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class CallProvider with ChangeNotifier {
  int myremoteUid = 0;
  bool localUserJoined = false;
  bool muted = false;
  bool videoPaused = false;
  bool switchMainView = false;
  bool mutedVideo = false;
  bool reConnectingRemoteView = false;
  bool isFront = false;
  late RtcEngine engine;

  Future<void> initilize() async {
    Future.delayed(Duration.zero, () async {
      await _initAgoraRtcEngine();
      _addAgoraEventHandlers();
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      VideoEncoderConfiguration configuration =
          const VideoEncoderConfiguration();
      await engine.setVideoEncoderConfiguration(configuration);
      await engine.leaveChannel();
      await engine.joinChannel(
        token: agoraTemptoken,
        channelId: agoraChannelId,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
      notifyListeners();
    });
  }

  Future<void> _initAgoraRtcEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await engine.enableVideo();
    //await engine.startPreview();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  void _addAgoraEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            localUserJoined = true;
            notifyListeners();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            localUserJoined = true;
            myremoteUid = remoteUid;
            notifyListeners();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            if (reason == UserOfflineReasonType.userOfflineDropped) {
              Wakelock.disable();
              myremoteUid = 0;
              onCallEnd();
              notifyListeners();
            } else {
              myremoteUid = 0;
              onCallEnd();
              notifyListeners();
            }
          },
          onTokenPrivilegeWillExpire:
              (RtcConnection connection, String token) {},
          onLeaveChannel: (RtcConnection connection, stats) {}),
    );
  }

  void onCallEnd() {
    clear();
    Helper.toRemoveUntilScreen(const ChatsScreen());
  }

  void onToggleMute() {
    muted = !muted;
    engine.muteLocalAudioStream(muted);
    notifyListeners();
  }

  void onToggleMuteVideo() {
    mutedVideo = !mutedVideo;
    engine.muteLocalVideoStream(mutedVideo);
  }

  void onSwitchCamera() {
    engine.switchCamera().then((value) => {}).catchError((err) {});
  }

  clear() {
    engine.leaveChannel();
    isFront = false;
    reConnectingRemoteView = false;
    videoPaused = false;
    muted = false;
    mutedVideo = false;
    switchMainView = false;
    localUserJoined = false;
    notifyListeners();
  }
}
