import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Generic button widget
class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed; // ✅ تم تعديلها لتكون nullable
  final String text;
  final double? heigth;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? overlayColor;
  final TextStyle? textStyle;
  final Widget? icon;
  final TextDirection? textDirection;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed, // لا تزال مطلوبة ولكن يمكن أن تكون null
    this.heigth,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
    this.icon,
    this.borderColor,
    this.overlayColor,
    this.textDirection,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection ?? TextDirection.ltr,
      child: SizedBox(
        width: width ?? double.infinity,
        height: heigth ?? 50.h,
        child: ElevatedButton.icon(
          onPressed: onPressed, // ✅ يقبل null بدون خطأ
          icon: icon ?? const SizedBox.shrink(),
          iconAlignment: IconAlignment.start,
          style: OutlinedButton.styleFrom(
            shadowColor: Colors.transparent,
            overlayColor: overlayColor ??Theme.of(context).primaryColor,
            side: BorderSide(color: borderColor ?? Colors.transparent),
            backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            ),
          ),
          label: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
