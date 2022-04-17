import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';

class UIUtils {
  static ElevatedButton getButton(
    String text,
    VoidCallback? onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white70, //bkg color
        onPrimary: Colors.black, //text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: DimenConstants.txtMedium,
        ),
      ),
      onPressed: onPressed,
    );
  }

  static Text getText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: DimenConstants.txtMedium,
      ),
    );
  }
}
