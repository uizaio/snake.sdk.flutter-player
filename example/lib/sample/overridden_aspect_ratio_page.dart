import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

class OverriddenAspectRatioPage extends StatefulWidget {
  const OverriddenAspectRatioPage({Key? key}) : super(key: key);

  @override
  _OverriddenAspectRatioPageState createState() =>
      _OverriddenAspectRatioPageState();
}

class _OverriddenAspectRatioPageState extends State<OverriddenAspectRatioPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.fill,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, VideoConstants.forBiggerBlazesUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setOverriddenAspectRatio(1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overridden aspect ratio"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Player with different rotation and fit.",
              style: TextStyle(fontSize: 16),
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
