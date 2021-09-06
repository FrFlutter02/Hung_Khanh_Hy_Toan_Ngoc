import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constant_colors.dart';

final boxDecorationStyle = BoxDecoration(
  color: AppColor.white,
  borderRadius: BorderRadius.circular(8.r),
  boxShadow: [
    BoxShadow(
      color: AppColor.secondaryGrey.withOpacity(0.12),
      blurRadius: 10,
      spreadRadius: 10,
      offset: Offset(0, 3),
    ),
  ],
);
