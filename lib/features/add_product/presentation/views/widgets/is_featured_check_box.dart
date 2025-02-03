import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_checkbox.dart';

class IsFeaturedCheckBox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool? isAlreadyChecked;
  const IsFeaturedCheckBox(
      {super.key, required this.onChanged, this.isAlreadyChecked});

  @override
  State<IsFeaturedCheckBox> createState() => _IsFeaturedCheckBoxState();
}

class _IsFeaturedCheckBoxState extends State<IsFeaturedCheckBox> {
  late bool isChecked;
  @override
  void initState() {
     isChecked = widget.isAlreadyChecked ?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        CustomCheckBox(
            isChecked:isChecked,
            onChecked: (value) {
              setState(() {
                isChecked = value;
                widget.onChanged(value);
              });
            }),
        horizontalSpace(16),
        Text(
          'منتج مميز ؟',
          style: TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
        )
      ],
    );
  }
}
