import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';


class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isChecked, required this.onChecked});
final bool isChecked;

  final ValueChanged<bool> onChecked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(microseconds: 100,),
        decoration: ShapeDecoration(
          color: isChecked? AppColors.primaryColor:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xffDCDEDE))
          ),
        ),child: isChecked? const Icon(Icons.check,color: Colors.white,size: 20,):const SizedBox.shrink(),
      ),
    );
  }
}