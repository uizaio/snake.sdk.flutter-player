import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_player_flutter/snake_player_flutter.dart';
import 'package:snake_player_flutter_example/lib/util/ui_utils.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  BaseStatefulState();

  void showAlertDialogWidget(
    bool barrierDismissible,
    String title,
    Widget widgetMessage,
    String cancelTitle,
    VoidCallback cancelAction,
    String okTitle,
    VoidCallback okAction,
  ) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: Center(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
              padding: const EdgeInsets.fromLTRB(
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff232426),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: DimenConstants.marginPaddingMedium),
                  widgetMessage,
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: cancelTitle.isNotEmpty == true,
                        child: (okTitle.isNotEmpty == true)
                            ? (Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                      DimenConstants.marginPaddingMedium,
                                      DimenConstants.marginPaddingMedium *
                                          2 /
                                          3,
                                      DimenConstants.marginPaddingMedium,
                                      DimenConstants.marginPaddingMedium *
                                          2 /
                                          3,
                                    ),
                                    primary: const Color(0xff0A79F8),
                                    backgroundColor: const Color(0xffffffff),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      side: BorderSide(
                                          color: Color(0xffDEE1EB), width: 1.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                    cancelAction.call();
                                  },
                                  child: Text(
                                    cancelTitle,
                                  ),
                                ),
                              ))
                            : (TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                    DimenConstants.marginPaddingMedium,
                                    DimenConstants.marginPaddingMedium * 2 / 3,
                                    DimenConstants.marginPaddingMedium,
                                    DimenConstants.marginPaddingMedium * 2 / 3,
                                  ),
                                  primary: const Color(0xff0A79F8),
                                  backgroundColor: const Color(0xffffffff),
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: Color(0xffDEE1EB), width: 1.0),
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  cancelAction.call();
                                },
                                child: Text(
                                  cancelTitle,
                                ),
                              )),
                      ),
                      Visibility(
                        visible: okTitle.isNotEmpty == true,
                        child: const SizedBox(
                            width: DimenConstants.marginPaddingSmall),
                      ),
                      Visibility(
                        visible: okTitle.isNotEmpty == true,
                        child: Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(
                                DimenConstants.marginPaddingMedium,
                                DimenConstants.marginPaddingMedium * 2 / 3,
                                DimenConstants.marginPaddingMedium,
                                DimenConstants.marginPaddingMedium * 2 / 3,
                              ),
                              primary: const Color(0xffffffff),
                              backgroundColor: const Color(0xff2B67F6),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    DimenConstants.radiusRound)),
                                side: BorderSide(
                                    color: Color(0xff2B67F6), width: 1.0),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                              okAction.call();
                            },
                            child: Text(
                              okTitle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: child,
        );
      },
    );
  }

  void showAlertDialog(
    bool barrierDismissible,
    String title,
    String message,
    String? cancelTitle,
    VoidCallback? cancelAction,
    String? okTitle,
    VoidCallback? okAction,
  ) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: Center(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
              padding: const EdgeInsets.fromLTRB(
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff232426),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: DimenConstants.marginPaddingMedium),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff232426),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: cancelTitle != null &&
                            cancelTitle.isNotEmpty == true,
                        child: (okTitle != null && okTitle.isNotEmpty == true)
                            ? (Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                      DimenConstants.marginPaddingMedium,
                                      DimenConstants.marginPaddingMedium *
                                          2 /
                                          3,
                                      DimenConstants.marginPaddingMedium,
                                      DimenConstants.marginPaddingMedium *
                                          2 /
                                          3,
                                    ),
                                    primary: const Color(0xff0A79F8),
                                    backgroundColor: const Color(0xffffffff),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      side: BorderSide(
                                          color: Color(0xffDEE1EB), width: 1.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                    cancelAction?.call();
                                  },
                                  child: Text(
                                    cancelTitle ?? "",
                                  ),
                                ),
                              ))
                            : (TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                    DimenConstants.marginPaddingMedium,
                                    DimenConstants.marginPaddingMedium * 2 / 3,
                                    DimenConstants.marginPaddingMedium,
                                    DimenConstants.marginPaddingMedium * 2 / 3,
                                  ),
                                  primary: const Color(0xff0A79F8),
                                  backgroundColor: const Color(0xffffffff),
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: Color(0xffDEE1EB), width: 1.0),
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  cancelAction?.call();
                                },
                                child: Text(
                                  cancelTitle ?? "",
                                ),
                              )),
                      ),
                      Visibility(
                        visible: okTitle != null && okTitle.isNotEmpty == true,
                        child: const SizedBox(
                            width: DimenConstants.marginPaddingSmall),
                      ),
                      Visibility(
                        visible: okTitle != null && okTitle.isNotEmpty == true,
                        child: Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(
                                DimenConstants.marginPaddingMedium,
                                DimenConstants.marginPaddingMedium * 2 / 3,
                                DimenConstants.marginPaddingMedium,
                                DimenConstants.marginPaddingMedium * 2 / 3,
                              ),
                              primary: const Color(0xffffffff),
                              backgroundColor: const Color(0xff2B67F6),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                side: BorderSide(
                                    color: Color(0xff2B67F6), width: 1.0),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                              okAction?.call();
                            },
                            child: Text(
                              okTitle ?? "",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: child,
        );
      },
    );
  }

  void showErrorDialog(
    String title,
    String message,
    String cancelTitle,
    VoidCallback cancelCallback,
  ) {
    showAlertDialog(
      false,
      title,
      message,
      cancelTitle,
      cancelCallback,
      null,
      null,
    );
  }

  void showConfirmDialog(
    String title,
    String message,
    String okTitle,
    VoidCallback okCallback,
  ) {
    showAlertDialog(
      false,
      title,
      message,
      null,
      null,
      okTitle,
      okCallback,
    );
  }

  void showSnackBarFull(
    String title,
    String message,
  ) {
    UIUtils.showFullWidthSnackBar(title, message);
  }

  void showSnackBarFullError(
    String title,
    String message,
  ) {
    UIUtils.showFullWidthSnackBarError(title, message);
  }

  void showDialogSuccess(
    Widget textCenter,
    bool barrierDismissible,
    Function onClickConfirm,
  ) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: Center(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
              padding: const EdgeInsets.fromLTRB(
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                DimenConstants.marginPaddingMedium,
                0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(DimenConstants.radiusMedium),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/ic_success.png",
                    height: 45,
                    width: 45,
                  ),
                  const SizedBox(height: DimenConstants.marginPaddingMedium),
                  textCenter,
                  const SizedBox(height: DimenConstants.marginPaddingMedium),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(
                          DimenConstants.marginPaddingMedium * 5 / 2,
                          0,
                          DimenConstants.marginPaddingMedium * 5 / 2,
                          0,
                        ),
                        primary: const Color(0xff2B67F6),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side:
                              BorderSide(color: Color(0xffDEE1EB), width: 1.0),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onClickConfirm.call();
                      },
                      child: const Text(
                        "Đóng",
                      ),
                    ),
                  ),
                  const SizedBox(height: DimenConstants.marginPaddingMedium),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: child,
        );
      },
    );
  }
}
