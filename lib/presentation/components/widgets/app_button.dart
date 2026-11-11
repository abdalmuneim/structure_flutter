import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:structure_flutter/presentaions/components/extensions/widget_extension.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/app_gradient.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_image.dart';

class AppButton extends Container {
  AppButton({
    super.key,
    String title = "",
    Color? backgroundColor = AppColors.primary,
    Color textColor = AppColors.secondary,
    double fontSize = AppFonts.subtitle1,
    FontWeight fontWeight = FontWeight.w500,
    double radius = AppDimens.large,
    double minWidth = double.infinity,
    double height = 53,
    VoidCallback? onPressed,
    String? icon,
    IconData? suffixFontAwesomeIcon,
    IconData? suffixIcon,
    IconData? prefixIcon,
    String? prefixImage,
    int prefixMargin = 5,
    Widget? prefixWidget,
    Color? prefixColor,
    double iconSize = 20,
    borderColor = AppColors.hide,
    double borderWidth = AppDimens.border,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    bool horizontalGradient = true,
    bool gradient = false,
    bool shadow = false,
  }) : super(
         decoration: BoxDecoration(
           gradient: gradient
               ? AppGradient(isHorizontal: horizontalGradient)
               : null,
           border: Border.all(
             color: borderColor,
             style: BorderStyle.solid,
             width: borderWidth,
           ),
           color: gradient ? null : backgroundColor,
           borderRadius: BorderRadius.all(Radius.circular(radius)),
           boxShadow: shadow && onPressed != null
               ? [
                   BoxShadow(
                     color: AppColors.primary.withValues(alpha: .20),
                     blurRadius: 5.00,
                     spreadRadius: 0,
                     offset: const Offset(0, 3.77),
                   ),
                 ]
               : [],
         ),
         child: MaterialButton(
           minWidth: minWidth,
           height: height,
           disabledColor: const Color(0xffE9EAEE),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(radius),
           ),
           elevation: 0,
           color: gradient ? null : backgroundColor,
           padding: EdgeInsets.zero,
           textColor: onPressed != null ? textColor : AppColors.white,
           onPressed: onPressed,
           disabledTextColor: AppColors.white,
           child: ChildButton(
             icon: icon,
             fontAwesomeIcon: suffixFontAwesomeIcon,
             suffixIcon: suffixIcon,
             prefixImage: prefixImage,
             prefixMargin: prefixMargin,
             prefixWidget: prefixWidget,
             prefixIcon: prefixIcon,
             title: title,
             fontSize: fontSize,
             fontWeight: fontWeight,
             iconSize: fontSize,
             mainAxisAlignment: mainAxisAlignment,
             prefixColor: prefixColor,
             key: key,
           ),
         ),
       );
}

class ChildButton extends StatelessWidget {
  const ChildButton({
    super.key,
    this.icon,
    this.fontAwesomeIcon,
    this.suffixIcon,
    this.prefixImage,
    required this.prefixMargin,
    this.prefixWidget,
    this.prefixIcon,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    required this.iconSize,
    required this.mainAxisAlignment,
    this.prefixColor,
  });
  final String? icon;
  final IconData? fontAwesomeIcon;
  final IconData? suffixIcon;
  final String? prefixImage;
  final int prefixMargin;
  final Widget? prefixWidget;
  final IconData? prefixIcon;
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconSize;
  final MainAxisAlignment mainAxisAlignment;
  final Color? prefixColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) appImage(icon!, width: iconSize, height: iconSize),
        if (fontAwesomeIcon != null) FaIcon(fontAwesomeIcon, size: iconSize),
        icon != null || fontAwesomeIcon != null
            ? const SizedBox(width: 5)
            : const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        if (prefixIcon != null)
          Row(
            children: [
              5.width,
              FaIcon(prefixIcon, size: iconSize),
            ],
          ),
        if (prefixImage != null)
          Row(
            children: [
              prefixMargin.width,
              RotatedBox(
                quarterTurns: Localizations.localeOf(context).languageCode == "en" ? 0 : 2,
                child: appImage(
                  prefixImage!,
                  width: iconSize,
                  height: iconSize,
                  color: prefixColor,
                ),
              ),
            ],
          ),
        if (prefixWidget != null) Row(children: [5.width, prefixWidget!]),
      ],
    );
  }
}
