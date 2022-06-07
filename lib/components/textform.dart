import 'package:flutter/material.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/style.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?)? validatior;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  const MyTextForm(
      {Key? key,
      required this.controller,
      this.validatior,
      this.onChanged,
      this.labelText,
      this.suffixIcon,
      required this.obscureText,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: style.copyWith(fontWeight: FontWeight.w500),
        obscureText: obscureText,
        cursorColor: Colors.black54,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        validator: validatior,
        decoration: InputDecoration(
          fillColor: AppColor.lightGrey,
          filled: true,
          hintText: labelText,
          hintStyle: style.copyWith(color: AppColor.hintTextColor),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: AppColor.orange,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: AppColor.orange,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: AppColor.orange,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          suffixIcon: suffixIcon,
        ));
  }
}
