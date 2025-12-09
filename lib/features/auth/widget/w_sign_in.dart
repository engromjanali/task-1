import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/core/constants/dimension_theme.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:task_one/core/extensions/ex_expanded.dart';
import 'package:task_one/core/extensions/ex_padding.dart';
import 'package:task_one/core/extensions/ex_strings.dart';
import 'package:task_one/core/functions/f_is_null.dart';
import 'package:task_one/core/functions/f_printer.dart';
import 'package:task_one/core/services/image_picker_services.dart';
import 'package:task_one/core/widgets/image/m_image_payload.dart';
import 'package:task_one/core/widgets/image/w_image.dart';
import 'package:task_one/core/widgets/w_have_account.dart';
import 'package:task_one/core/widgets/w_image_source_dialog.dart';
import 'package:task_one/core/widgets/w_text_field.dart';
import 'package:task_one/gen/assets.gen.dart';
import 'package:image_picker/image_picker.dart';

class WSignIn extends StatefulWidget {
  final Function()? onNavigate;
  const WSignIn({super.key, this.onNavigate});

  @override
  State<WSignIn> createState() => _WSignInState();
}

class _WSignInState extends State<WSignIn> {
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  ValueNotifier<bool> isSignin = ValueNotifier(true);
  ValueNotifier<XFile> pickedImage = ValueNotifier(XFile(""));
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    printer("w sign in build");
    return ValueListenableBuilder(
      valueListenable: isSignin,
      builder: (context, value, child) {
        return Container(
          height: value
              ? (400.h + MediaQuery.of(context).viewInsets.vertical)
              : (500.h + MediaQuery.of(context).viewInsets.vertical),
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.circular(PTheme.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // profile
              if (!value)
                ValueListenableBuilder(
                  valueListenable: pickedImage,
                  builder: (context, value, asyncSnapshot) {
                    return WImage(
                      onTap: () async {
                        ImageSource? imageSource = await WISSDialog(context);
                        if (isNotNull(imageSource)) {
                          pickedImage.value =
                              await SvImagePicker().pickSingleImage(
                                choseFrom: imageSource!,
                              ) ??
                              value;
                        }
                      },
                      pickedImage.value.path,
                      payload: MImagePayload(
                        isCircular: true,
                        height: 90.w,
                        width: 90.w,
                        isProfileImage: true,
                      ),
                    );
                  },
                ),
              // input fields
              Form(
                key: fromKey,
                child: Column(
                  spacing: 16.h,
                  children: [
                    if (!value)
                      WTextField.requiredField(
                        controller: nameController,
                        label: "Name",
                        prefixIconPath: Assets.icons.person,
                      ).withKey(ValueKey("Name")),
                    WTextField.requiredField(
                      controller: emailController,
                      label: "Email",
                      validator: (value) {
                        if (!(value ?? "").isValidEmail) {
                          return "Invalid Email!";
                        }
                        return null;
                      },
                      prefixIconPath: Assets.icons.email,
                    ).withKey(ValueKey("email")),
                    WTextField.obsecureText(
                      controller: passController,
                      label: "Password",
                      validator: (value) {
                        if (isNull(value)) {
                          return "Enter Password!";
                        }
                        final regex = RegExp(
                          r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$',
                        );
                        bool res = regex.hasMatch(value!);
                        if (res) {
                          // valid
                          return null;
                        } else {
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return "At least 1 uppercase letter";
                          }
                          if (!value.contains(RegExp(r'\d+'))) {
                            return "At least 1 number";
                          }
                          if (value.trim().length < 6) {
                            return "value must be at least 6 characters";
                          }
                        }
                      },
                      prefixIconPath: Assets.icons.lock,
                    ).withKey(ValueKey("pass")),
                  ],
                ),
              ),
              // button
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WHaveAccount(
                    label: value ? 'New Here?' : "Have An Account?",
                    actionText: value ? 'Sign Up' : "Sign In",
                    onTap: () {
                      isSignin.value = !value;
                    },
                  ),
                  WCElevatedButton(
                    ontap: () {
                      if (fromKey.currentState?.validate() ?? false) {
                        widget.onNavigate?.call();
                      }
                    },
                    label: value ? "Sign In" : "Sign Up",
                    margin: EdgeInsets.all(0),
                  ).pT(),
                ],
              ),
              // social login
              if (value)
                Row(
                  spacing: 30.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.social.facebook.path,
                      height: 40.r,
                      width: 40.r,
                    ),
                    Image.asset(
                      Assets.social.google.path,
                      height: 40.r,
                      width: 40.r,
                    ),
                  ],
                ).pV(),
              SizedBox(height: MediaQuery.of(context).viewInsets.vertical),
            ],
          ).pAll(),
        );
      },
    );
  }
}
