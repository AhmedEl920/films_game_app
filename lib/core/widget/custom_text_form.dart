import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatefulWidget {
  final String hintText;
  final TextAlign? textAlign;
  final String? initialValue;
  final bool? isValidator;
  final bool? isObscureText;
  final bool? isclickable;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Color? hoverColor;
  final Color? fillColor;
  final Color? colorEnableBorder;
  final Color? disabledBorder;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxLines;
  final FormFieldSetter<String>? onSaved;
  final Key? valueKey;
  final Function()? onTap;
  final String? apiError;

  const CustomTextForm({
    super.key,
    required this.hintText,
    this.contentPadding,
    this.isObscureText,
    this.hintStyle,
    this.style,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.cursorColor,
    this.cursorErrorColor,
    this.hoverColor,
    this.fillColor,
    this.focusNode,
    this.nextFocusNode,
    this.colorEnableBorder,
    this.maxLines,
    this.onSaved,
    this.valueKey,
    this.isclickable,
    this.disabledBorder,
    this.initialValue,
    this.onTap,
    this.textAlign,
    this.isValidator,
    this.apiError,
  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.valueKey,
      initialValue: widget.initialValue,
      enabled: widget.isclickable,
      readOnly: widget.isclickable ?? false,
      onTap: widget.onTap,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(widget.nextFocusNode),
      focusNode: widget.focusNode,
      onChanged: widget.onSaved,
      maxLines: widget.maxLines ?? 1,
      textAlign: widget.textAlign ?? TextAlign.start,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      style: widget.style,
      obscureText: _obscureText,
      cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      cursorErrorColor: widget.cursorErrorColor ?? Colors.red,
      validator: widget.isValidator ?? true
          ? (value) {
              if (value == null || value.isEmpty) {
                return '${widget.hintText} مطلوب';
              }
              return null;
            }
          : widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).hintColor,
              fontFamily: 'Amiri',
              fontSize: 16.sp,
            ),
        isDense: true,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(14.r),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        suffixIconConstraints: BoxConstraints(minWidth: 14.w, minHeight: 8.h),
        hoverColor: widget.hoverColor,
        filled: true,
        fillColor: widget.fillColor ?? Theme.of(context).primaryColor.withOpacity(0.05) ,
        errorText: widget.apiError,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.r)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          borderSide: BorderSide(
            color: widget.colorEnableBorder ?? Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isObscureText == true) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }
}
