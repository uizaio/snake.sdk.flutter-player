import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_word/lib/util/uI_utils.dart';
import 'package:hello_word/lib/util/video_utils.dart';
import 'package:video_player/video_player.dart';

import 'controls_overlay.dart';

class BumbleBeeRemoteVideo extends StatefulWidget {
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<BumbleBeeRemoteVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _setupVideo();
  }

  void _setupVideo() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      closedCaptionFile: SnakeUtils.loadCaptions(
          context, 'assets/videos/bumble_bee_captions.srt'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.setLooping(true);
    _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar("With remote mp4", () {
        Get.back();
      }, null),
      body: ListView(
        children: [
          _buildVideoView(),
        ],
      ),
    );
  }

  Widget _buildVideoView() {
    if (_controller == null) {
      return Container();
    } else {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller!),
            ClosedCaption(text: _controller!.value.caption.text),
            ControlsOverlay(controller: _controller!),
            VideoProgressIndicator(_controller!, allowScrubbing: true),
          ],
        ),
      );
    }
  }
}
