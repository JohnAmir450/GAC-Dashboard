import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
    return showDialog(context: context, builder:(context)=> Center(child: LoadingAnimationWidget.inkDrop(
          color: AppColors.secondaryColor, size: 32)));
  }