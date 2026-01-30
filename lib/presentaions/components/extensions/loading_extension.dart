import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/widgets/progress_view.dart';
import '../utils/ui/ui.dart';

extension Loading on State {
  static bool loaderVisible = false;
  static CancelFunc? cancelFunc;

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showLoading({
    BuildContext? context,
    bool showProgress = false,
    Duration? duration,
    bool canCancelLoading = false,
  }) {
    if (context != null) {
      closeKeyboard(context);
    }
    if (canCancelLoading) {
      loaderVisible = false;
    } else {
      loaderVisible = true;
    }
    if (cancelFunc != null) cancelFunc!.call();
    cancelFunc = BotToast.showCustomLoading(
      duration: duration,
      toastBuilder: (CancelFunc cancelFunc) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.loadingBackground.withValues(alpha: .35),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Center(child: ProgressView(false)),
            ],
          ),
        );
      },
      backgroundColor: AppColors.hide,
    );
  }

  void hideLoading() {
    if (cancelFunc != null) cancelFunc!.call();
    loaderVisible = false;
  }

  getLoadingStatus() {
    return loaderVisible;
  }
}
