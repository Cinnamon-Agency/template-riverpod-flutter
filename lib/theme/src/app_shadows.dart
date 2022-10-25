import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

class AppShadows {
  static BoxShadow primary = BoxShadow(
    color: AppColors.primaryDark.withOpacity(0.2),
    blurRadius: 20,
    spreadRadius: -20,
    offset: const Offset(0, 10),
  );
}
