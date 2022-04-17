import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

import '../common/constant/video_constants.dart';

class PlaceholderUntilPlayPage extends StatefulWidget {
  const PlaceholderUntilPlayPage({Key? key}) : super(key: key);

  @override
  _PlaceholderUntilPlayPageState createState() =>
      _PlaceholderUntilPlayPageState();
}

class _PlaceholderUntilPlayPageState extends State<PlaceholderUntilPlayPage> {
  late BetterPlayerController _betterPlayerController;
  final StreamController<bool> _placeholderStreamController =
      StreamController.broadcast();
  bool _showPlaceholder = true;

  @override
  void dispose() {
    _placeholderStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      fit: BoxFit.contain,
      placeholder: _buildVideoPlaceholder(),
      showPlaceholderUntilPlay: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.elephantDreamVideoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        _setPlaceholderVisibleState(false);
      }
    });
    super.initState();
  }

  void _setPlaceholderVisibleState(bool hidden) {
    _placeholderStreamController.add(hidden);
    _showPlaceholder = hidden;
  }

  ///_placeholderStreamController is used only to refresh video placeholder
  ///widget.
  Widget _buildVideoPlaceholder() {
    return StreamBuilder<bool>(
      stream: _placeholderStreamController.stream,
      builder: (context, snapshot) {
        return _showPlaceholder
            ? Image.network(VideoConstants.placeholderUrl)
            : const SizedBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlaceholderUntilPlayPage"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Normal player with placeholder shown until video is started.",
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
        ],
      ),
    );
  }
}
