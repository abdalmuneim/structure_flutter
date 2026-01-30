import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';

class Alert {
  static final Alert _instance = Alert();

  static Alert get instance {
    return _instance;
  }

  void showSuccess(String? message, {int duration = 2}) {
    if (message == null || message.isEmpty) return;
    showToast(
      message,
      FontAwesomeIcons.circleCheck, //solidCheckCircle deprecated icon
      AppColors.success,
      duration: duration,
    );
  }

  void showWarning(String? message, {int duration = 2}) {
    if (message == null || message.isEmpty) return;
    showToast(
      message,
      FontAwesomeIcons.exclamationTriangle,
      AppColors.warning,
      duration: duration,
    );
  }

  void showError(String? message, {int duration = 5}) {
    if (message == null || message.isEmpty) return;
    showToast(
      message,
      FontAwesomeIcons.exclamationTriangle,
      AppColors.error,
      duration: duration,
    );
  }

  void showToast(
    String message,
    IconData icon,
    Color color, {
    int duration = 2,
  }) {
    BotToast.showCustomText(
      duration: Duration(seconds: duration),
      onlyOne: true,
      align: const Alignment(0, 0.8),
      toastBuilder: (_) => Card(
        color: color,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(icon, color: AppColors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
