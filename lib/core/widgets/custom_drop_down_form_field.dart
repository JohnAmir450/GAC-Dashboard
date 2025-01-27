import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';

class CustomCategoryDropDownButtonFormField extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  const CustomCategoryDropDownButtonFormField({
    super.key,
    this.value,
    this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value, // Default selected value
      decoration: InputDecoration(
        labelText: 'الفئة',
        
        labelStyle: TextStyles.bold16.copyWith(color: const Color(0xff949D9E)),
        hintText: 'اختر الفئة',
        hintStyle: TextStyles.bold13.copyWith(color: const Color(0xff949D9E)),
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
      items: items,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى اختيار الفئة';
        }
        return null;
      },
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: Color(0xffE6E9E9)),
    );
  }
}
