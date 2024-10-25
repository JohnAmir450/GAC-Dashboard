import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gac_dashboard/core/helper_functions/get_user_data.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customAppBar(title: 'لوحة التحكم',
      leading: 
        SizedBox(width: 130,
          child: ListTile(
               title:  Text('مرحبًا بك !',style: TextStyles.regular16.copyWith(color: Color(0xff949D9E),),
          ),
          subtitle:  Text(getUserData().name!,style: TextStyles.bold16),
          //trailing:const  CustomNotificationIcon(),
          ),
        )),
      body: DashboardViewBody(),
    );
  }
}

