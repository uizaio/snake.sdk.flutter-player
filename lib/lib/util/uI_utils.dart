import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hello_word/lib/common/const/dimen_constants.dart';

class UIUtils {
  static AppBar getAppBar(
    String text,
    VoidCallback? onPressed,
    VoidCallback? onPressCodeViewer,
  ) {
    Widget _buildActionCodeWidget() {
      if (onPressCodeViewer == null) {
        return Container();
      } else {
        return IconButton(
          icon: Icon(
            Icons.code,
            color: Colors.white,
          ),
          onPressed: onPressCodeViewer,
        );
      }
    }

    return AppBar(
      title: Text(text),
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),

      //add action on appbar
      actions: <Widget>[
        _buildActionCodeWidget(),
      ],
      backgroundColor: Colors.blue,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static ElevatedButton getButton(
    String text,
    VoidCallback? onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white70, //bkg color
        onPrimary: Colors.black, //text color
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(DimenConstants.radiusMedium),
        ),
      ),

      child: new Text(
        text,
        style: TextStyle(
          // color: Colors.black,
          fontSize: DimenConstants.txtMedium,
        ),
      ),
      // color: Colors.white70,
      onPressed: onPressed,
    );
  }

  static Text getText(String text) {
    return Text(
      text,
      style: UIUtils.getStyleText(),
    );
  }

  static TextStyle getStyleText() {
    return TextStyle(
      color: Colors.black,
      fontSize: DimenConstants.txtMedium,
    );
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String message,
    String? cancelTitle,
    VoidCallback? cancelAction,
    String okTitle,
    VoidCallback? okAction,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff232426),
          ),
        ),
        title: Text(title),
        actions: [
          if (cancelTitle != null)
            CupertinoDialogAction(
              child: Text(
                cancelTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff0A79F8),
                ),
              ),
              isDefaultAction: true,
              onPressed: () {
                Get.back();
                cancelAction?.call();
              },
            ),
          CupertinoDialogAction(
            child: Text(
              okTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFF0000),
              ),
            ),
            onPressed: () {
              Get.back();
              okAction?.call();
            },
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
    String okTitle,
    VoidCallback? okCallback,
  ) {
    showAlertDialog(
      context,
      title,
      message,
      null,
      null,
      okTitle,
      okCallback,
    );
  }

  static void showSnackBar(
    String title,
    String message,
  ) {
    Get.snackbar(
      title, // title
      message, // message
      // barBlur: 20,
      isDismissible: true,
      duration: Duration(seconds: 3),
    );
  }

  static Widget buildHorizontalDivider(
      Color color, double width, double height) {
    return Container(
      margin: EdgeInsets.all(0.0),
      height: height,
      width: width,
      color: color,
    );
  }

  static Widget buildVerticalDivider(Color color, double height) {
    return Container(
      margin: EdgeInsets.all(0.0),
      height: height,
      width: 1,
      color: color,
    );
  }

  static void showFullWidthSnackBar(String title, String message,
      {bool isTop = true}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      duration: Duration(seconds: 2),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xff232426),
        ),
      ),
      icon: Image(
        image: AssetImage('assets/images/ic_check_mark_green.png'),
        width: 20,
        height: 15,
      ),
      backgroundColor: Color.fromARGB(255, 212, 245, 217),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      colorText: Color.fromARGB(255, 35, 36, 38),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }

  static void showFullWidthSnackBarError(String title, String message,
      {bool isTop = true}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      duration: Duration(seconds: 2),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xff232426),
        ),
      ),
      icon: Image(
        image: AssetImage('assets/images/ic_x.png'),
        width: 20,
        height: 20,
        color: Color(0xffF13232),
      ),
      backgroundColor: Color(0xffFFDFDF),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      colorText: Color(0xff232426),
      snackPosition: isTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }
}
