import 'package:flutter/material.dart';
import '../../utils/ui/ui.dart';

class AppGradient extends LinearGradient {
  AppGradient({bool isHorizontal = true, double? opacity})
      : super(
          colors: [
            isHorizontal
                ? opacity != null
                    ? AppColors.startGradient.withValues(alpha: opacity)
                    : AppColors.startGradient
                : opacity != null
                    ? AppColors.endGradient.withValues(alpha: opacity)
                    : AppColors.endGradient,
            isHorizontal
                ? opacity != null
                    ? AppColors.endGradient.withValues(alpha: opacity)
                    : AppColors.endGradient
                : opacity != null
                    ? AppColors.startGradient.withValues(alpha: opacity)
                    : AppColors.startGradient,
          ],
          end: isHorizontal
              ? const FractionalOffset(0.0, 0.0)
              : const FractionalOffset(1.0, 0.0),
          begin: const FractionalOffset(1.0, 1.0),
          stops: [0.2, 0.8],
          tileMode: TileMode.repeated,
        );
}

// use to make text color gradient
// TextStyle(foreground: Paint()..shader = AppGradient().createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))
