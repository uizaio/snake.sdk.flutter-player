import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

import '../common/constant/video_constants.dart';

class OverriddenDurationPage extends StatefulWidget {
  const OverriddenDurationPage({Key? key}) : super(key: key);

  @override
  _OverriddenDurationPageState createState() => _OverriddenDurationPageState();
}

class _OverriddenDurationPageState extends State<OverriddenDurationPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      handleLifecycle: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _setupDataSource();
    super.initState();
  }

  void _setupDataSource() async {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.elephantDreamVideoUrl,

      ///Play only 10 seconds of this video.
      overriddenDuration: const Duration(seconds: 10),
    );
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OverriddenDurationPage"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Duration of this video is overridden. Now this video will have"
              " 10 seconds only.",
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}
