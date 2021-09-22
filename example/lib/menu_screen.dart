import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/sample/basic_player_page.dart';
import 'package:snake_player_flutter_example/sample/cache_page.dart';
import 'package:snake_player_flutter_example/sample/controls_configuration_page.dart';
import 'package:snake_player_flutter_example/sample/event_listener_page.dart';
import 'package:snake_player_flutter_example/sample/hls_audio_page.dart';
import 'package:snake_player_flutter_example/sample/hls_subtitles_page.dart';
import 'package:snake_player_flutter_example/sample/hls_tracks_page.dart';
import 'package:snake_player_flutter_example/sample/normal_player_page.dart';
import 'package:snake_player_flutter_example/sample/playlist_page.dart';
import 'package:snake_player_flutter_example/sample/resolutions_page.dart';
import 'package:snake_player_flutter_example/sample/subtitles_page.dart';

import 'common/constant/video_constants.dart';
import 'common/util/ui_utils.dart';
import 'common/util/url_launcher_utils.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    _saveAssetSubtitleToFile();
    _saveAssetVideoToFile();
    _saveAssetEncryptVideoToFile();
    _saveLogoToFile();
    super.initState();
  }

  ///Save subtitles to file, so we can use it later
  Future _saveAssetSubtitleToFile() async {
    String content =
        await rootBundle.loadString("assets/example_subtitles.srt");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/example_subtitles.srt");
    file.writeAsString(content);
  }

  ///Save video to file, so we can use it later
  Future _saveAssetVideoToFile() async {
    var content =
        await rootBundle.load("assets/${VideoConstants.fileTestVideoUrl}");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/${VideoConstants.fileTestVideoUrl}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  Future _saveAssetEncryptVideoToFile() async {
    var content = await rootBundle
        .load("assets/${VideoConstants.fileTestVideoEncryptUrl}");
    final directory = await getApplicationDocumentsDirectory();
    var file =
        File("${directory.path}/${VideoConstants.fileTestVideoEncryptUrl}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  ///Save logo to file, so we can use it later
  Future _saveLogoToFile() async {
    var content = await rootBundle.load("assets/${VideoConstants.logo}");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/${VideoConstants.logo}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MenuScreen'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
        children: [
          UIUtils.getButton(
            "BasicPlayerPage",
            () {
              Get.to(const BasicPlayerPage());
            },
          ),
          UIUtils.getButton(
            "NormalPlayerPage",
                () {
              Get.to(const NormalPlayerPage());
            },
          ),
          UIUtils.getButton(
            "ControlsConfigurationPage",
                () {
              Get.to(const ControlsConfigurationPage());
            },
          ),
          UIUtils.getButton(
            "EventListenerPage",
                () {
              Get.to(const EventListenerPage());
            },
          ),
          UIUtils.getButton(
            "SubtitlesPage",
                () {
              Get.to(const SubtitlesPage());
            },
          ),
          UIUtils.getButton(
            "ResolutionsPage",
                () {
              Get.to(const ResolutionsPage());
            },
          ),
          UIUtils.getButton(
            "HlsSubtitlesPage",
                () {
              Get.to(const HlsSubtitlesPage());
            },
          ),
          UIUtils.getButton(
            "HlsTracksPage",
                () {
              Get.to(const HlsTracksPage());
            },
          ),
          UIUtils.getButton(
            "HlsAudioPage",
                () {
              Get.to(const HlsAudioPage());
            },
          ),
          UIUtils.getButton(
            "CachePage",
                () {
              Get.to(const CachePage());
            },
          ),
          UIUtils.getButton(
            "PlaylistPage",
                () {
              Get.to(const PlaylistPage());
            },
          ),
          const SizedBox(height: 100),
          UIUtils.getButton(
            "Github",
            () {
              UrlLauncherUtils.launchInWebViewWithJavaScript(
                  "https://github.com/uizaio/snake.sdk.flutter-player");
            },
          ),
          UIUtils.getButton(
            "Rate app",
            () {
              UrlLauncherUtils.rateApp(null, null);
            },
          ),
          UIUtils.getButton(
            "Policy",
            () {
              UrlLauncherUtils.launchInWebViewWithJavaScript(
                  "https://loitp.wordpress.com/2018/06/10/dieu-khoan-su-dung-chinh-sach-bao-mat-va-quyen-rieng-tu/");
            },
          ),
        ],
      ),
    );
  }
}
