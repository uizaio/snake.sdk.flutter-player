import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter_example/player/model/video_list_data.dart';

class VideoListWidget extends StatefulWidget {
  final VideoListData? videoListData;

  const VideoListWidget({Key? key, this.videoListData}) : super(key: key);

  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  VideoListData? get videoListData => widget.videoListData;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = const BetterPlayerConfiguration(
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              videoListData!.videoTitle,
              style: const TextStyle(fontSize: 50),
            ),
          ),
          AspectRatio(
              child: BetterPlayerListVideoPlayer(
                BetterPlayerDataSource(
                  BetterPlayerDataSourceType.network,
                  videoListData!.videoUrl,
                  notificationConfiguration:
                      BetterPlayerNotificationConfiguration(
                          showNotification: true,
                          title: videoListData!.videoTitle,
                          author: "Test"),
                  bufferingConfiguration:
                      const BetterPlayerBufferingConfiguration(
                          minBufferMs: 2000,
                          maxBufferMs: 10000,
                          bufferForPlaybackMs: 1000,
                          bufferForPlaybackAfterRebufferMs: 2000),
                ),
                configuration: const BetterPlayerConfiguration(
                  autoPlay: false,
                  aspectRatio: 1,
                ),
                //key: Key(videoListData.hashCode.toString()),
                playFraction: 0.8,
                betterPlayerListVideoPlayerController: controller,
              ),
              aspectRatio: 1),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
                "Horror: In Steven Spielberg's Jaws, a shark terrorizes a beach "
                "town. Plainspoken sheriff Roy Scheider, hippie shark "
                "researcher Richard Dreyfuss, and a squirrely boat captain "
                "set out to find the beast, but will they escape with their "
                "lives? 70's special effects, legendary score, and trademark "
                "humor set this classic apart."),
          ),
          Center(
            child: Wrap(children: [
              ElevatedButton(
                child: const Text("Play"),
                onPressed: () {
                  controller!.play();
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                child: const Text("Pause"),
                onPressed: () {
                  controller!.pause();
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                child: const Text("Set max volume"),
                onPressed: () {
                  controller!.setVolume(100);
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}