import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/core/constants/dimension_theme.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:task_one/core/extensions/ex_padding.dart';
import 'package:task_one/core/services/navigation_service.dart';

class WBackButton extends StatelessWidget {
  double size;
  WBackButton({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigation.pop(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(50),
            borderRadius: BorderRadius.circular(PTheme.borderRadius),
          ),
          child: SizedBox.square(
            dimension: size.w + 10.w,
            child: Icon(Icons.adaptive.arrow_back, size: size.w),
          ),
        ).pH(),
      ),
    );
  }
}
