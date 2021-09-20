import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_word/lib/common/const/video_constants.dart';
import 'package:hello_word/lib/util/uI_utils.dart';
import 'package:hello_word/lib/util/video_utils.dart';
import 'package:video_player/video_player.dart';

import 'controls_overlay.dart';

class RemoteVideoScreen extends StatefulWidget {
  @override
  _RemoteVideoScreenState createState() => _RemoteVideoScreenState();
}

class _RemoteVideoScreenState extends State<RemoteVideoScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // _playMp4Landscape();
  }

  void _setupVideo(String link, String? closedCaptionFile) {
    var _videoPlayerOptions = VideoPlayerOptions(mixWithOthers: true);

    if (closedCaptionFile == null || closedCaptionFile.isEmpty) {
      _controller = VideoPlayerController.network(
        link,
        videoPlayerOptions: _videoPlayerOptions,
      );
    } else {
      _controller = VideoPlayerController.network(
        link,
        closedCaptionFile: SnakeUtils.loadCaptions(context, closedCaptionFile),
        videoPlayerOptions: _videoPlayerOptions,
      );
    }

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

  void _playMp4Landscape() {
    _setupVideo(VideoConstants.videoMp4Landscape,
        'assets/videos/bumble_bee_captions.srt');
  }

  void _playMp4Landscape2() {
    _setupVideo(VideoConstants.videoMp4Landscape2, null);
  }

  void _playMp4Portrait() {
    _setupVideo(VideoConstants.videoMp4Portrait1, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RemoteVideoScreen'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          _buildVideoView(),
          SizedBox(height: 50),
          UIUtils.getButton("Mp4 Landscape", () {
            _playMp4Landscape();
          }),
          UIUtils.getButton("Mp4 Landscape 2", () {
            _playMp4Landscape2();
          }),
          UIUtils.getButton("Mp4 Portrait", () {
            _playMp4Portrait();
          }),
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
