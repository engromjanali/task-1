import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/core/constants/dimension_theme.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:task_one/core/extensions/ex_padding.dart';
import 'package:task_one/core/services/navigation_service.dart';
import 'package:task_one/core/widgets/w_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?> WISSDialog(BuildContext context) async {
  return await WDialog.showCustom(
    context: context,
    children: [
      Text("Take photo from", style: context.textTheme?.titleSmall),
      gapY(40),
      WCElevatedButton(
        ontap: () {
          Navigator.pop(context, ImageSource.gallery);
        },
        label: "Photo Library",
        backgroundColor: context.primaryTextColor,
        foregroundColor: context.backgroundColor,
        margin: EdgeInsets.all(10),
      ),
      WCElevatedButton(
        ontap: () {
          Navigator.pop(context, ImageSource.camera);
        },
        label: "Camera",
        backgroundColor: context.backgroundColor,
        foregroundColor: context.primaryTextColor,
        margin: EdgeInsets.only(bottom: 30, top: 10, left: 10, right: 10),
      ),
    ],
  );
}

class WCElevatedButton extends StatelessWidget {
  final Function() ontap;
  final String label;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final Size? size;
  final BorderRadius? borderRadius;
  const WCElevatedButton({
    super.key,
    this.foregroundColor,
    this.backgroundColor,
    required this.ontap,
    required this.label,
    this.margin,
    this.size,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        height: size?.height ?? 50.h,
        width: size?.width ?? double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? context.button?.primary,
            foregroundColor: foregroundColor ?? context.backgroundColor,
            minimumSize: Size(double.maxFinite, 30.h),
            elevation: 0,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.circular(PTheme.borderRadius),
            ),
          ),
          onPressed: ontap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
