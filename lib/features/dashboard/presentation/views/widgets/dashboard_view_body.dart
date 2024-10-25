import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/widgets/custom_button.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 30.h),
      child: Column(
        children: [
          CustomButton(text: 'اضافة منتج',onPressed: (){
            context.pushNamed(Routes.addProductView);
          }),
        ],
      ),
    );
  }
}