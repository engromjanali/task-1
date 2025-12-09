import 'package:flutter/material.dart';
import 'package:task_one/core/functions/f_printer.dart';
import 'package:task_one/core/functions/f_snackbar.dart';
import 'package:task_one/core/services/navigation_service.dart';
import 'package:task_one/features/auth/widget/w_sign_in.dart';

/// 🔁 A checkpoint to handle initialization and navigation after a short delay.
class CCheckPoint {
  Future<void> initialization() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // set environment here
    // al done navigate to home screen.
    // showModalBottomSheet(
    await showModalBottomSheet(
      context: NavigationService.currentContext,
      isScrollControlled: true,
      // scrollControlDisabledMaxHeightRatio: 0.5,
      // isDismissible: false,
      // useSafeArea: true,
      builder: (_) {
        printer("hii -2");
        // return Placeholder(child: Center(child: TextField()));
        return WSignIn(
          onNavigate: () {
            showSnackBar("Welcome!");
          },
        );
      },
    );
    // await const SHome().pushAndRemoveUntil();
  }
}
