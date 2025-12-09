import 'package:task_one/core/constants/dimension_theme.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:task_one/core/extensions/ex_expanded.dart';

import 'package:task_one/core/extensions/ex_padding.dart';
import 'package:task_one/core/functions/f_is_null.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_one/core/widgets/w_container.dart';
import 'package:task_one/core/widgets/w_icon.dart';
import 'package:task_one/gen/assets.gen.dart';

/// ✏️🔒 WTextField
/// A feature-rich and flexible text input field:
/// 🏷️ Optional label and hint
/// 🔐 Secure input support via `.obsecureText` constructor
/// ✅ Required field support via `.requiredField`
/// 🧠 Custom validator and input format
/// 👀 Optional prefix/suffix widgets or icons (e.g., SVG)
/// 🎯 Auto/manual focus support, controller lifecycle
/// 📲 Keyboard type control for input specificity
/// 🎉 Comes with built-in error handling, label styling, and optional visibility toggle for passwords
class WTextField extends StatefulWidget {
  final String? initialText;
  final String? label;
  final String? hintText;
  final String? prefixIconPath;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final bool enable;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool autoDispose;
  final TextInputType? keyboardType;
  final bool isRequired;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final AutovalidateMode? autovalidateMode;
  final TextAlignVertical? textAlignVertical;
  const WTextField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIconPath,
    this.prefix,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.enable = true,
    this.onTap,
    this.onChanged,
    this.autoDispose = true,
    this.keyboardType,
    this.initialText,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction = TextInputAction.next,
    this.expands,
    this.autovalidateMode,
    this.textAlignVertical,
  }) : obsecureText = false,
       isRequired = false;

  const WTextField.obsecureText({
    super.key,
    this.label,
    this.hintText,
    this.prefixIconPath,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.prefix,
    this.enable = true,
    this.onTap,
    this.onChanged,
    this.autoDispose = true,
    this.keyboardType,
    this.initialText,
    this.focusNode,
    this.isRequired = true,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction = TextInputAction.next,
    this.expands,
    this.autovalidateMode,
    this.textAlignVertical,
  }) : obsecureText = true;
  const WTextField.requiredField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIconPath,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.prefix,
    this.enable = true,
    this.onTap,
    this.onChanged,
    this.autoDispose = true,
    this.keyboardType,
    this.initialText,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction = TextInputAction.next,
    this.expands,
    this.autovalidateMode,
    this.textAlignVertical,
  }) : obsecureText = false,
       isRequired = true;

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  late final ValueNotifier<bool> obsecureText = ValueNotifier<bool>(
    widget.obsecureText,
  );
  TextEditingController? _controller;
  bool _isControllerOwner = false; // 🔹 tracking ownership

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      _controller = TextEditingController(text: widget.initialText);
      _isControllerOwner = true;
    }
  }

  @override
  void dispose() {
    if (_isControllerOwner) {
      _controller?.dispose(); // ✅ only dispose if we created it
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget constant = Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: obsecureText,
          builder: (_, value, __) {
            return _textField();
          },
        ).expd(value: widget.expands ?? false ? 1 : 0),
      ],
    );
    return (widget.expands ?? false) ? constant.expd() : constant;
  }

  Widget _textField() {
    return WContainer(
      verticalPadding: 0,
      child: Stack(
        children: [
          TextFormField(
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,

            validator: (v) {
              final validation = widget.validator?.call(v);

              if (validation != null) {
                return validation;
              }

              if (widget.isRequired && (v == null || v.isEmpty)) {
                return "Please enter ${widget.label}";
              }
              return null;
            },
            expands: widget.expands ?? false,
            obscureText: obsecureText.value,
            controller: _controller,
            readOnly: !widget.enable,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            autovalidateMode:
                widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            textInputAction: widget.textInputAction,
            style: context.textTheme?.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              filled: false,
              fillColor: context.fillColor,
              errorStyle: context.textTheme?.labelSmall?.copyWith(
                color: context.redColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: widget.prefixIconPath == null ? 10.w : 0.0,
              ),
              hintText:
                  widget.hintText ??
                  (widget.label == null ? null : "Enter ${widget.label}"),
              prefixIcon:
                  // Icon(Icons.abc),
                  widget.prefix != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.prefix!,
                        SvgPicture.asset(
                          Assets.icons.divider,
                          height: 20.w,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                            context.primaryTextColor ?? Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    )
                  : widget.prefixIconPath == null
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WIcon(path: widget.prefixIconPath!),
                        WIcon(path: Assets.icons.divider),
                      ],
                    ),
              suffixIcon: widget.obsecureText
                  ? InkWell(
                      onTap: () {
                        obsecureText.value = !obsecureText.value;
                      },
                      child: Icon(
                        obsecureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : widget.suffixIcon,
            ),
          ),
          if (widget.isRequired)
            Positioned(
              child: Text("*", style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
