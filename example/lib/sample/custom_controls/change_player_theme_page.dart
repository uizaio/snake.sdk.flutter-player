import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/common/constant/video_constants.dart';

import 'custom_controls_widget.dart';

class ChangePlayerThemePage extends StatefulWidget {
  const ChangePlayerThemePage({Key? key}) : super(key: key);

  @override
  _ChangePlayerThemePageState createState() => _ChangePlayerThemePageState();
}

class _ChangePlayerThemePageState extends State<ChangePlayerThemePage> {
  late BetterPlayerController _betterPlayerController;
  BetterPlayerDataSource? _dataSource;
  BetterPlayerTheme _playerTheme = BetterPlayerTheme.material;

  @override
  void initState() {
    super.initState();
    String url = VideoConstants.bugBuckBunnyVideoUrl;
    _dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, url);
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoDispose: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: _playerTheme,
        ),
      ),
      betterPlayerDataSource: _dataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change player theme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
              child: Text(
                "Player with the possibility to change the theme. Click on "
                "buttons below to change theme of player.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            BetterPlayer(
              controller: _betterPlayerController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  child: const Text("MATERIAL"),
                  onPressed: () {
                    setState(() {
                      _playerTheme = BetterPlayerTheme.material;
                      _betterPlayerController.pause();
                      _betterPlayerController = BetterPlayerController(
                        BetterPlayerConfiguration(
                          autoDispose: true,
                          controlsConfiguration:
                              BetterPlayerControlsConfiguration(
                            playerTheme: _playerTheme,
                          ),
                        ),
                        betterPlayerDataSource: _dataSource,
                      );
                    });
                  },
                ),
                MaterialButton(
                  child: const Text("CUPERTINO"),
                  onPressed: () {
                    setState(() {
                      _playerTheme = BetterPlayerTheme.cupertino;
                      _betterPlayerController.pause();
                      _betterPlayerController = BetterPlayerController(
                        BetterPlayerConfiguration(
                          autoDispose: true,
                          controlsConfiguration:
                              BetterPlayerControlsConfiguration(
                            playerTheme: _playerTheme,
                          ),
                        ),
                        betterPlayerDataSource: _dataSource,
                      );
                    });
                  },
                ),
                MaterialButton(
                  child: const Text("CUSTOM"),
                  onPressed: () {
                    setState(() {
                      _playerTheme = BetterPlayerTheme.custom;
                      _betterPlayerController.pause();
                      _betterPlayerController = BetterPlayerController(
                        BetterPlayerConfiguration(
                          autoDispose: true,
                          controlsConfiguration:
                              BetterPlayerControlsConfiguration(
                            playerTheme: _playerTheme,
                            customControlsBuilder: (controller) =>
                                CustomControlsWidget(
                              controller: controller,
                            ),
                          ),
                        ),
                        betterPlayerDataSource: _dataSource,
                      );
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
