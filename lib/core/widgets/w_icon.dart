import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';

/// SVGs behave differently because their viewBox and internal drawing size are not the same.
/// thst's why is was not fix in tehe given size that's why we have to use witn in a size box to force rander it.
class WIcon extends StatelessWidget {
  final String path;
  final double size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  const WIcon({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.size = 20,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.w ?? size.w,
      width: width?.w ?? size.w,
      child: SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.contain,
        colorFilter: ColorFilter.mode(
          color ?? context.primaryTextColor ?? Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
