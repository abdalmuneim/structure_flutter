import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';

class AppOutlineInputBorder extends OutlineInputBorder {
  AppOutlineInputBorder({
    Color color = AppColors.grey,
    double width = AppDimens.border,
    double radius = AppDimens.large,
    FocusNode? focusNode,
    bool border = true,
    bool grayBorder = false,
    bool isReadOnly = false,
    bool forceBorder = false,
  }) : super(
         borderSide: border
             ? BorderSide(color: color, width: 1)
             : BorderSide.none,
         borderRadius: BorderRadius.circular(radius),
       );
}
