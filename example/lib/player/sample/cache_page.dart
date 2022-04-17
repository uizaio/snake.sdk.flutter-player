import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/player/common/constant/video_constants.dart';

class CachePage extends StatefulWidget {
  const CachePage({Key? key}) : super(key: key);

  @override
  _CachePageState createState() => _CachePageState();
}

class _CachePageState extends State<CachePage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.phantomVideoUrl,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,

        ///Android only option to use cached video between app sessions
        key: "testCacheKey",
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CachePage"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
            child: Text(
              "Player with cache enabled. To test this feature, first plays "
              "video, then leave this page, turn internet off and enter "
              "page again. You should be able to play video without "
              "internet connection.",
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          TextButton(
            child: const Text("Start pre cache"),
            onPressed: () {
              _betterPlayerController.preCache(_betterPlayerDataSource);
            },
          ),
          TextButton(
            child: const Text("Stop pre cache"),
            onPressed: () {
              _betterPlayerController.stopPreCache(_betterPlayerDataSource);
            },
          ),
          TextButton(
            child: const Text("Play video"),
            onPressed: () {
              _betterPlayerController.setupDataSource(_betterPlayerDataSource);
            },
          ),
          TextButton(
            child: const Text("Clear cache"),
            onPressed: () {
              _betterPlayerController.clearCache();
            },
          ),
        ],
      ),
    );
  }
}
