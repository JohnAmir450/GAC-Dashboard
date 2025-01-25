import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomAnimatedLoadingWidget extends StatelessWidget {
  const CustomAnimatedLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingAnimationWidget.inkDrop(
          color: AppColors.secondaryColor, size: 32));
  }
}