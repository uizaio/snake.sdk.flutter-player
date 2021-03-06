import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

class AdvancedPlayerPage extends StatefulWidget {
  const AdvancedPlayerPage({Key? key}) : super(key: key);

  @override
  _AdvancedPlayerPageState createState() => _AdvancedPlayerPageState();
}

class _AdvancedPlayerPageState extends State<AdvancedPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  String _customLink = "";

  @override
  void initState() {
    BetterPlayerControlsConfiguration _controlsConfiguration =
        BetterPlayerControlsConfiguration(
      controlBarColor: Colors.indigoAccent.withAlpha(200),
      iconsColor: Colors.lightGreen,
      playIcon: Icons.forward,
      progressBarPlayedColor: Colors.grey,
      progressBarHandleColor: Colors.lightGreen,
      enableSkips: false,
      enableFullscreen: false,
      controlBarHeight: 60,
      loadingColor: Colors.red,
      overflowModalColor: Colors.indigo,
      overflowModalTextColor: Colors.white,
      overflowMenuIconsColor: Colors.white,
    );
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      looping: true,
      placeholder: const Center(
        child: Text(
          "Ex: This is place holder",
          style: TextStyle(color: Colors.red),
        ),
      ),
      showPlaceholderUntilPlay: true,
      overlay: Container(
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: const Text(
          "Ex: This is widget overlay",
          style: TextStyle(color: Colors.green),
        ),
      ),
      controlsConfiguration: _controlsConfiguration,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
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
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
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
          const SizedBox(height: 100),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter your link',
            ),
            onChanged: (text) {
              setState(() {
                _customLink = text;
              });
            },
          ),
          ElevatedButton(
            child: const Text("Play custom link"),
            onPressed: () async {
              if (_customLink.isNotEmpty) {
                _setupPlayer(_customLink);
              }
            },
          ),
        ],
      ),
    );
  }
}
