import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

class AdvancedPlayerPage extends StatefulWidget {
  const AdvancedPlayerPage({Key? key}) : super(key: key);

  @override
  _AdvancedPlayerPageState createState() => _AdvancedPlayerPageState();
}

class _AdvancedPlayerPageState extends State<AdvancedPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
    const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _setupPlayer(VideoConstants.forBiggerBlazesUrl);
    super.initState();
  }

  void _setupPlayer(String link) {
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      link,
    );
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdvancedPlayerPage"),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          ElevatedButton(
            child: const Text("Play Mp4"),
            onPressed: () async {
              _setupPlayer(VideoConstants.forBiggerBlazesUrl);
            },
          ),
          ElevatedButton(
            child: const Text("Play VOD"),
            onPressed: () async {
              _setupPlayer(VideoConstants.linkPlayVOD);
            },
          ),
          ElevatedButton(
            child: const Text("Play LIVE"),
            onPressed: () async {
              _setupPlayer(VideoConstants.linkPlayLIVE);
            },
          ),
        ],
      ),
    );
  }
}
