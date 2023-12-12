import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            offset: const Offset(0, 2),
            blurRadius: 4.r,
            color: color000000.withOpacity(0.12),
          ),
        ],
      ),
      child: child,
    );
  }
}
