import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structure_flutter/core/helpers/constants.dart';

import 'package:structure_flutter/presentaions/components/extensions/widget_extension.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'app_image.dart';
import 'input_error.dart';
import 'outline_input_border.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final String label;
  final String? title;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final bool obscureText;
  final TextEditingController? controller;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final Widget? icon;
  final int? maxLength;
  final String? initValue;
  final bool enable;
  final String? image;
  final double? imageSize;
  final Widget? endSuffix;
  final bool enableEdit;
  final Icon? endIcon;
  final Widget? suffix;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefix;
  final TextStyle? prefixStyle;
  final String? prefixText;
  final GestureTapCallback? onSuffixTap;
  final int maxLines;
  final bool showCounter;
  final List<TextInputFormatter>? formatter;
  final Color? iconColor;
  final Color fillColor;
  final Color hintColor;
  final double radius;
  final bool enableInteractiveSelection;
  final bool withBorders;
  final Color? titleColor;
  final TextAlign textAlign;
  final String? errorMessage;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    this.hint,
    this.label = "",
    this.title,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSubmit,
    this.obscureText = false,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.icon,
    this.maxLength,
    this.initValue,
    this.enable = true,
    this.image,
    this.imageSize = 24,
    this.endSuffix,
    this.enableEdit = false,
    this.endIcon,
    this.suffix,
    this.onSuffixTap,
    this.maxLines = 1,
    this.showCounter = false,
    this.formatter,
    this.iconColor,
    this.fillColor = AppColors.fourth,
    this.hintColor = AppColors.grey,
    this.radius = AppDimens.large,
    this.enableInteractiveSelection = true,
    this.withBorders = true,
    this.titleColor = AppColors.primary,
    this.prefix,
    this.prefixStyle,
    this.prefixText,
    this.textAlign = TextAlign.start,
    this.errorMessage,
    this.contentPadding,
    this.suffixIconConstraints,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool showBorder = false;
  FocusNode focusNode = FocusNode();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    errorMessage = widget.errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Column(
            children: [
              Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.titleColor,
                ),
              ),
              5.height,
            ],
          ),
        TextFormField(
          key: widget.key,
          textAlign: widget.textAlign,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          maxLines: widget.maxLines,
          initialValue: widget.initValue,
          maxLength: widget.maxLength,
          controller: widget.controller,
          inputFormatters: widget.formatter,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          focusNode: focusNode,
          enabled: widget.enable,
          textAlignVertical: TextAlignVertical.top,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          onChanged: (value) =>
              widget.onChanged != null ? widget.onChanged!(value) : null,
          onFieldSubmitted: (value) =>
              widget.onSubmit != null ? widget.onSubmit!(value) : null,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            fillColor: widget.fillColor,
            filled: true,
            counterText: widget.showCounter ? null : "",
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.only(top: 20, bottom: 5, right: 15, left: 15),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: widget.hint,
            labelText: widget.label,
            prefixStyle: widget.prefixStyle,
            prefixText: widget.prefixText,
            labelStyle: const TextStyle(
              fontSize: AppFonts.caption,
              color: AppColors.grey,
            ),
            floatingLabelStyle: const TextStyle(
              fontSize: AppFonts.caption,
              color: AppColors.orange,
            ),
            errorMaxLines: 2,
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color(0xffC5C5C5),
              fontFamily: AppConstants.arabicAppFont,
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
            enabledBorder: AppOutlineInputBorder(
              border: widget.withBorders,
              radius: widget.radius,
              color: AppColors.grey.withValues(alpha: .20),
              isReadOnly: widget.readOnly,
              focusNode: focusNode,
            ),
            focusedBorder: AppOutlineInputBorder(
              isReadOnly: widget.readOnly,
              radius: widget.radius,
              color: AppColors.primary,
              forceBorder: showBorder,
              focusNode: focusNode,
            ),
            disabledBorder: AppOutlineInputBorder(
              color: AppColors.grey.withValues(alpha: .20),
              isReadOnly: widget.readOnly,
              radius: widget.radius,
              forceBorder: showBorder,
              focusNode: focusNode,
            ),
            errorBorder: AppOutlineInputBorder(
              color: AppColors.grey.withValues(alpha: .20),
              isReadOnly: widget.readOnly,
              radius: widget.radius,
              forceBorder: showBorder,
              focusNode: focusNode,
            ),
            focusedErrorBorder: AppOutlineInputBorder(
              color: AppColors.grey.withValues(alpha: .20),
              isReadOnly: widget.readOnly,
              radius: widget.radius,
              forceBorder: showBorder,
              focusNode: focusNode,
            ),
            errorStyle: const TextStyle(
              fontSize: 0,
              color: AppColors.transparent,
              overflow: TextOverflow.ellipsis,
            ),
            prefix: widget.prefix,
            prefixIcon: widget.icon != null || widget.image != null
                ? widget.icon ??
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: appImage(widget.image!, height: 3, width: 3),
                      )
                : null,
            suffix: widget.suffix,
            suffixIconConstraints: widget.suffixIconConstraints,
            suffixIcon: widget.endSuffix != null
                ? widget.enableEdit
                      ? InkWell(
                          onTap: widget.onSuffixTap,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "edit",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              widget.endSuffix ?? const SizedBox.shrink(),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: widget.onSuffixTap,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.endSuffix ?? const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        )
                : widget.endIcon,
          ),
          validator: widget.validator != null
              ? (value) {
                  var error = widget.validator!(value);
                  if (error != null) {
                    setState(() {
                      errorMessage = error;
                    });
                  } else {
                    setState(() {
                      errorMessage = null;
                    });
                  }
                  return error;
                }
              : null,
          obscureText: widget.obscureText,
        ),
        if (errorMessage != null) inputError(errorMessage!),
      ],
    );
  }
}
