import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';

AppBar customAppBar({required String title, Widget? leading}) {
  return AppBar(
    automaticallyImplyLeading: false,
    //leadingWidth: 130,
    title: Text(
      title,
      style: TextStyles.bold19,
    ),
    centerTitle: true,
    leading: leading,
  );
}
