import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    this.height,
    this.width,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
  }) : super(key: key);

  final void Function()? onTap;
  final double? height;
  final double? width;
  final dynamic buttonText;
  final Color? buttonColor;
  final bool isLoading;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: height ?? 25.sp,
        width: width ?? 150.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: buttonColor ?? Colors.grey,
        ),
        child: Center(
          child: SizedBox(
              height: 2.5.h,
              width: 5.w,
              child: const CircularProgressIndicator(color: Colors.white)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 25.sp,
          width: width ?? 150.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: buttonColor ?? Colors.grey,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor ?? Colors.black,
              ),
            ),
          ),
        ),
      );
    }
  }
}