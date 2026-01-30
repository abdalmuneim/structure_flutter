import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/extensions/builder_extension.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/alert.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/rich_alert_dialog.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_button.dart';

extension Alerts on State {
  void showSuccess(String message) {
    Alert.instance.showSuccess(message);
  }

  void showWarning(String message) {
    Alert.instance.showWarning(message);
  }

  void showError(String message) {
    Alert.instance.showError(message);
  }

  void successDialog({String? title, String? message, List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (context) {
        return RichAlertDialog(
          alertTitle: title,
          alertSubtitle: message,
          actions: actions,
          alertType: RichAlertType.SUCCESS,
        );
      },
    );
  }

  void errorDialog({
    String? title,
    String? message,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: !isDismissible ? () async => false : null,
          child: RichAlertDialog(
            alertTitle: title,
            alertSubtitle: message,
            actions: actions,
            alertType: RichAlertType.ERROR,
          ),
        );
      },
    );
  }

  void warningDialog({
    String? title,
    String? message,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: !isDismissible ? () async => false : null,
          child: RichAlertDialog(
            alertTitle: title,
            alertSubtitle: message,
            actions: actions,
            alertType: RichAlertType.WARNING,
          ),
        );
      },
    );
  }

  void generalDialog({
    String? title,
    String? message,
    List<Widget>? actions,
    bool isDismissible = true,
    DialogSize? dialogSize,
  }) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: !isDismissible ? () async => false : null,
          child: RichAlertDialog(
            alertTitle: title,
            alertSubtitle: message,
            actions: actions,
            dialogSize: dialogSize,
          ),
        );
      },
    );
  }

  alertDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Wrap(
            children: [
              Column(
                children: [
                  Text(message),
                  const SizedBox(height: 20),
                  AppButton(
                    title: "ok",
                    onPressed: () {
                      pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
