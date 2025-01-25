import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  const CustomCachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
    this.width
  });

  final String imageUrl;
  final double borderRadius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        width: width ,
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.lightSecondaryColor, size: 23),
        errorWidget: (context, url, error) => const Icon(
            Icons.error_outline,
            color: Colors.amber),
      ),
    );
  }
}