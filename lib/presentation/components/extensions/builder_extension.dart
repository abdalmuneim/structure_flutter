import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/core/bases/base_use_case.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';

extension SceneBuilder on State {
  Future<dynamic> push(BuildContext context, Widget screen) {
    return Navigator.push(context, CupertinoPageRoute(builder: (_) => screen));
  }

  Future<dynamic> pushNamed(String screenName, {Object? arguments}) {
    return BaseUseCase.navigatorKey.currentState!.pushNamed(
      screenName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushReplacement(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => screen),
    );
  }

  Future<dynamic> pushReplacementNamed(String screenName, {Object? arguments}) {
    return BaseUseCase.navigatorKey.currentState!.pushReplacementNamed(
      screenName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushAndRemoveUntil(
    BuildContext context,
    Widget screen,
    String path,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      ModalRoute.withName(path),
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String screenName, {
    Object? arguments,
  }) {
    return BaseUseCase.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      screenName,
      (route) {
        print(route.toString());
        return false;
      },
      arguments: arguments,
    );
  }

  Future bottomSheetViewer({
    required BuildContext context,
    required Widget screen,
    bool isScrollControlled = true,
    double? heightFactor,
    bool isDismissible = true,
    bool enableDrag = true,
    BorderRadius radius = BorderRadius.zero,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    Color? backgroundColor = Colors.transparent,
  }) {
    return showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: radius),
      isScrollControlled: isScrollControlled,
      builder: (context) => heightFactor != null
          ? Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              margin: margin,
              child: ClipRRect(
                borderRadius: radius,
                child: FractionallySizedBox(
                  heightFactor: heightFactor,
                  child: screen,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              margin: margin,
              child: ClipRRect(
                borderRadius: radius,
                child: Wrap(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: heightFactor,
                      child: screen,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future dialog({
    required BuildContext context,
    required Widget screen,
    bool dismissible = false,
    Color? barrierColor,
  }) async {
    return showDialog(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: dismissible,
      builder: (BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(children: [screen]),
      ),
    );
  }

  void animatedDialog({
    required BuildContext context,
    required Widget screen,
    bool dismissible = false,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(child: Wrap(children: [screen])),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: dismissible,
      context: context,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return Container();
          },
    );
  }

  pop({dynamic data}) {
    BaseUseCase.navigatorKey.currentState!.pop(data);
  }
}
