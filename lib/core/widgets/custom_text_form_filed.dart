import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_icon_button.dart';

class CustomTextFormField extends StatefulWidget {
  final String? title;

  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  bool isPassword;
  final bool isSuffixIconShown;

  CustomTextFormField({
    super.key,
     this.title,
    this.keyboardType,
    required this.validator,
    required this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.isSuffixIconShown = false,
    this.suffixIcon,
    required this.obscureText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      child: TextFormField(
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18.sp,
        ),
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white)),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isSuffixIconShown == true
              ? CustomIconButton(
                  onPressed: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  icon: widget.isPassword
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,color: Theme.of(context).primaryColor,
                )
              :        null,

          focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide: BorderSide(
                color: Colors.black,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          hintText: widget.title,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor,)
        ),
      ),
    );
  }
}
