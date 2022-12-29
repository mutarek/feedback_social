import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:als_frontend/provider/call_provider.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/secret.dart';
import 'package:provider/provider.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  void initState() {
    Provider.of<CallProvider>(context, listen: false).initilize();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<CallProvider>(context, listen: false).clear();
    super.dispose();
  }

  @override
  void deactivate() {
    Provider.of<CallProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<CallProvider>(builder: (context, callProvider, child) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: callProvider.localUserJoined == true
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: callProvider.engine,
                          canvas: VideoCanvas(uid: callProvider.myremoteUid),
                          connection:
                              const RtcConnection(channelId: agoraChannelId),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No Remote',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                      child: callProvider.localUserJoined
                          ? AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: callProvider.engine,
                                canvas: const VideoCanvas(uid: 0),
                              ),
                            )
                          : CircularProgressIndicator()),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callProvider.onToggleMute();
                          },
                          child: Icon(
                            callProvider.muted ? Icons.mic : Icons.mic_off,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callProvider.onCallEnd();
                          },
                          child: Icon(
                            Icons.call,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callProvider.onCallEnd();
                          },
                          child: Icon(
                            Icons.photo_camera_front,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callProvider.onSwitchCamera();
                          },
                          child: Icon(
                            Icons.switch_camera,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
