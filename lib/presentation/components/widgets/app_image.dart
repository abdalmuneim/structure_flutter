import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structure_flutter/generated/app_assets.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';

Widget appImage(
  String image, {
  double? height,
  double? width,
  BoxFit scale = BoxFit.contain,
  bool isFromFile = false,
  Color? color,
}) {
  if (isFromFile == true) {
    return Image.file(File(image), height: height, width: width, fit: scale);
  } else if (image.endsWith("svg")) {
    return SvgPicture.asset(
      image,
      height: height,
      width: width,
      fit: scale,
      color: color,
    );
  } else if (image.startsWith("http")) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: scale,
      placeholder: (context, url) => appImage(
        Assets.assetsImagesCommonLoadingIcon,
        height: 50,
        width: 50,
        color: AppColors.grey,
        scale: BoxFit.scaleDown,
      ),
      errorWidget: (context, url, error) => const FittedBox(
        fit: BoxFit.scaleDown,
        child: Icon(Icons.image, color: AppColors.grey, size: 50),
      ),
    );
  } else {
    return Image.asset(image, height: height, width: width, fit: scale);
  }
}
