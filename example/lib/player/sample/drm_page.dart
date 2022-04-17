import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

import '../common/constant/video_constants.dart';

class DrmPage extends StatefulWidget {
  const DrmPage({Key? key}) : super(key: key);

  @override
  _DrmPageState createState() => _DrmPageState();
}

class _DrmPageState extends State<DrmPage> {
  late BetterPlayerController _tokenController;
  late BetterPlayerController _widevineController;
  late BetterPlayerController _fairplayController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
    BetterPlayerDataSource _tokenDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.tokenEncodedHlsUrl,
      videoFormat: BetterPlayerVideoFormat.hls,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.token,
          token: VideoConstants.tokenEncodedHlsToken),
    );
    _tokenController = BetterPlayerController(betterPlayerConfiguration);
    _tokenController.setupDataSource(_tokenDataSource);

    _widevineController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _widevineDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.widevineVideoUrl,
      drmConfiguration: BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.widevine,
          licenseUrl: VideoConstants.widevineLicenseUrl,
          headers: {"Test": "Test2"}),
    );
    _widevineController.setupDataSource(_widevineDataSource);

    _fairplayController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource _fairplayDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      VideoConstants.fairplayHlsUrl,
      drmConfiguration: BetterPlayerDrmConfiguration(
        drmType: BetterPlayerDrmType.fairplay,
        certificateUrl: VideoConstants.fairplayCertificateUrl,
        licenseUrl: VideoConstants.fairplayLicenseUrl,
      ),
    );
    _fairplayController.setupDataSource(_fairplayDataSource);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DrmPage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
              child: Text(
                "Auth token based DRM.",
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _tokenController),
            ),
            const Padding(
              padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
              child: Text(
                "Widevine - license url based DRM. Works only for Android.",
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _widevineController),
            ),
            const Padding(
              padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
              child: Text(
                "Fairplay - certificate url based EZDRM. Works only for iOS.",
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _fairplayController),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
