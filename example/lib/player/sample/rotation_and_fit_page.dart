import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

import '../common/constant/video_constants.dart';

class RotationAndFitPage extends StatefulWidget {
  const RotationAndFitPage({Key? key}) : super(key: key);

  @override
  _RotationAndFitPageState createState() => _RotationAndFitPageState();
}

class _RotationAndFitPageState extends State<RotationAndFitPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 1.0,
      fit: BoxFit.fill,
      rotation: 90,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, VideoConstants.forBiggerBlazesUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RotationAndFitPage"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Player with different rotation and fit.",
            ),
          ),
          AspectRatio(
            aspectRatio: 1.0,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}
