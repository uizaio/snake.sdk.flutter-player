import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

class ControllerControlsPage extends StatefulWidget {
  const ControllerControlsPage({Key? key}) : super(key: key);

  @override
  _ControllerControlsPageState createState() => _ControllerControlsPageState();
}

class _ControllerControlsPageState extends State<ControllerControlsPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        VideoConstants.elephantDreamVideoUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ControllerControlsPage"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Control player with BetterPlayerController. You can control all"
              "aspects of player without using UI of player.",
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          Wrap(
            children: [
              TextButton(
                  child: const Text("Play"),
                  onPressed: _betterPlayerController.play),
              TextButton(
                  child: const Text("Pause"),
                  onPressed: _betterPlayerController.pause),
              TextButton(
                child: const Text("Hide controls"),
                onPressed: () {
                  _betterPlayerController.setControlsVisibility(false);
                },
              ),
              TextButton(
                child: const Text("Show controls"),
                onPressed: () {
                  _betterPlayerController.setControlsVisibility(true);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
