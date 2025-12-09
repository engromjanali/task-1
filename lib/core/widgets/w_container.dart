import 'package:task_one/core/constants/colors.dart';
import 'package:task_one/core/constants/dimension_theme.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/core/functions/f_is_null.dart';
import 'package:task_one/core/widgets/image/m_image_payload.dart';
import 'package:task_one/core/widgets/image/w_image.dart';

/// 📦 WContainer
/// A flexible, tappable container with customizable padding, border, color, and shape.
/// 💡 Ideal for wrapping content in a visually styled and optionally clickable box.
/// 🎯 Supports rectangular and circular shapes with optional border customization.
class WContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final Function()? onTap;
  final Color? borderColor;
  final double? verticalPadding, horizontalPadding, borderRadius;
  final BoxShape? boxShape;
  final List<BoxShadow>? boxShadow;
  final bool borderInDark;
  const WContainer({
    super.key,
    this.child,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.verticalPadding,
    this.horizontalPadding,
    this.borderColor,
    this.borderRadius,
    this.boxShape,
    this.boxShadow,
    this.borderInDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.w ?? PTheme.spaceX,
          horizontal: horizontalPadding?.w ?? PTheme.spaceX,
        ),
        decoration: BoxDecoration(
          color:
              color ??
              (context.theme.brightness == Brightness.dark
                  ? context.cardColor
                  : context.backgroundColor),
          shape: boxShape ?? BoxShape.rectangle,
          boxShadow: context.theme.brightness == Brightness.dark
              ? null
              : boxShadow ??
                    [
                      BoxShadow(
                        color: Color(0x403A3A3A),
                        blurRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],

          border: isNotNull(borderColor)
              ? context.theme.brightness == Brightness.dark && !borderInDark
                    ? null
                    : Border.all(
                        color:
                            borderColor ??
                            context
                                .theme
                                .inputDecorationTheme
                                .border!
                                .borderSide
                                .color,
                        width: 1.w,
                      )
              : null,
          borderRadius: boxShape == null
              ? BorderRadius.circular(borderRadius ?? PTheme.borderRadius)
              : null,
        ),
        child: child,
      ),
    );
  }
}
