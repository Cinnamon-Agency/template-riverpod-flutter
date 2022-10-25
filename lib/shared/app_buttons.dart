import 'package:flutter/material.dart';

import '../theme/src/app_colors.dart';
import '../theme/src/app_shadows.dart';
import '../theme/src/app_text_styles.dart';

class AppButtons {
  static Widget primary({
    required VoidCallback? onTap,
    required Widget child,
    double? width,
    Color? fillColor,
    Color? textColor,
  }) {
    final decoration = BoxDecoration(
      color: fillColor ?? (onTap == null ? Colors.grey[300] : AppColors.primary),
      border: Border.all(
        color: fillColor ?? (onTap == null ? Colors.grey[300]! : AppColors.primary),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [AppShadows.primary],
    );

    return Ink(
      decoration: decoration,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        highlightColor: textColor?.withOpacity(0.15) ?? AppColors.text.withOpacity(0.15),
        child: SizedBox(
          height: 50,
          width: width ?? double.infinity,
          child: Center(
            child: DefaultTextStyle.merge(
              style: AppTextStyles.bold.copyWith(color: textColor ?? AppColors.white),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
