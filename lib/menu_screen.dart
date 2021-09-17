import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hello_word/lib/common/const/dimen_constants.dart';
import 'package:hello_word/lib/util/url_launcher_utils.dart';
import 'package:hello_word/sample/video_player/player_video_and_pop_page.dart';
import 'package:hello_word/sample/video_player/bumble_bee_remote_video.dart';
import 'package:hello_word/sample/video_player/butter_fly_asset_video.dart';
import 'package:hello_word/sample/video_player/butter_fly_asset_video_in_list.dart';

import 'lib/util/uI_utils.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "Main menu",
        () {
          SystemNavigator.pop();
        },
        null,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
        children: [
          UIUtils.getButton(
            "BumbleBeeRemoteVideo",
            () {
              Get.to(BumbleBeeRemoteVideo());
            },
          ),
          UIUtils.getButton(
            "ButterFlyAssetVideo",
            () {
              Get.to(ButterFlyAssetVideo());
            },
          ),
          UIUtils.getButton(
            "ButterFlyAssetVideoInList",
            () {
              Get.to(ButterFlyAssetVideoInList());
            },
          ),
          UIUtils.getButton(
            "PlayerVideoAndPopPage",
            () {
              Get.to(PlayerVideoAndPopPage());
            },
          ),
          SizedBox(height: 100),
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
