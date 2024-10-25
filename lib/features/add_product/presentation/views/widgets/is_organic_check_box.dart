import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_checkbox.dart';

class IsOrganicCheckBox extends StatefulWidget {
    final ValueChanged<bool> onChanged;
  const IsOrganicCheckBox({super.key, required this.onChanged});

  @override
  State<IsOrganicCheckBox> createState() => _IsOrganicCheckBoxState();
}

class _IsOrganicCheckBoxState extends State<IsOrganicCheckBox> {
  bool isChecked = true;
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
        Text('منتج نباتي ؟',style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),)
       
       ],
    );
  }
}
