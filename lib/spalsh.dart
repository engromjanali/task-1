import 'package:task_one/core/controllers/c_check_point.dart';
import 'package:task_one/core/extensions/ex_build_context.dart';
import 'package:task_one/core/extensions/ex_padding.dart';
import 'package:task_one/core/functions/f_printer.dart';
import 'package:task_one/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    // tmp true
    if (true) {
      final CCheckPoint checkPoint = CCheckPoint();
      checkPoint.initialization(
      );
      printer("checkAuth");
    }
  }

  @override
  Widget build(BuildContext context) {
    printer("splash");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        // onDoubleTap: checkAuth,
        onDoubleTap: () {
          checkAuth();
        },
        child: Container(
          color: Colors.black,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    Assets.images.logo.path,
                    height: 300.w,
                    width: 300.w,
                  ),
                ),
              ),
              Text(
                "Loading...",
                style: context.textTheme?.titleSmall?.copyWith(
                  color: Colors.white,
                ),
              ).pB(value: 50),
            ],
          ),
        ),
      ),
    );
  }
}
