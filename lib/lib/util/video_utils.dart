import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SnakeUtils {
  static Future<ClosedCaptionFile> loadCaptions(
      BuildContext context, String key) async {
    final String fileContents =
        await DefaultAssetBundle.of(context).loadString(key);
    return SubRipCaptionFile(fileContents);
  }
}
