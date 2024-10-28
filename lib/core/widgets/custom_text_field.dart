import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final bool? isObscured;
  final void Function(String)? onChanged;
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.textInputType,
      this.suffixIcon,
      this.labelText,
      this.onChanged,
      this.controller,
      this.isObscured,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: isObscured ?? false,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: textInputType ?? TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,labelStyle: TextStyles.bold16.copyWith(color: const Color(0xff949D9E)),
        suffixIcon: suffixIcon,
        suffixIconColor: const Color(0xff949D9E),
        hintText: hintText,
        hintStyle: TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          4.0,
        ),
        borderSide: const BorderSide(color: Color(0xffE6E9E9)));
  }
}