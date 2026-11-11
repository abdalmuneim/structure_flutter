import 'package:flutter/cupertino.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/generated/app_assets.dart';
import 'package:structure_flutter/presentaions/components/extensions/widget_extension.dart';

import 'app_image.dart';

Widget inputError(String errorMessage) {
  return Column(
    children: [
      10.height,
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.error, width: 1),
        ),
        child: Row(
          children: [
            appImage(Assets.assetsImagesCommonAlert),
            10.width,
            Text(
              errorMessage,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.third,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
