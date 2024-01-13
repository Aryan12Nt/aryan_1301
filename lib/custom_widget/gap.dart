import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 14.sp,
      width: width ?? 14.sp,
    );
  }
}

class Gap3 extends StatelessWidget {
  const Gap3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 3.h);
  }
}

class Gap5 extends StatelessWidget {
  const Gap5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 5.h);
  }
}

class Gap1 extends StatelessWidget {
  const Gap1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 1.h);
  }
}

class Gap2 extends StatelessWidget {
  const Gap2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 2.h);
  }
}

class GapWidth extends StatelessWidget {
  const GapWidth({
    this.width,
    super.key,
  });
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}