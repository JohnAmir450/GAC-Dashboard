import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_checkbox.dart';

class IsFeaturedCheckBox extends StatefulWidget {
    final ValueChanged<bool> onChanged;
  const IsFeaturedCheckBox({super.key, required this.onChanged});

  @override
  State<IsFeaturedCheckBox> createState() => _IsFeaturedCheckBoxState();
}

class _IsFeaturedCheckBoxState extends State<IsFeaturedCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [CustomCheckBox(
        isChecked: isChecked,
      
       onChecked: (value){
        setState(() {
          isChecked = value;
        widget.onChanged(value);
        });

       }),
       horizontalSpace(16),
        Text('منتج مميز ؟',style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),)
       
       ],
    );
  }
}
