import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VisibleProductsItem extends StatelessWidget {
  const VisibleProductsItem({
    super.key, required this.productEntity,
  });
  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.updateProductView,arguments: productEntity);
      
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[180],
            border: Border.all(color: AppColors.primaryColor, width: 0.8),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  imageUrl: productEntity.imageUrl! ,
                  placeholder: (context, url) => LoadingAnimationWidget.threeRotatingDots(color: AppColors.lightSecondaryColor, size: 23),
                  errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.amber),
                ),
              ),
                    horizontalSpace(8),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productEntity.name, style: TextStyles.bold16),
                    Text('${productEntity.price} جنية/الكرتونة',
                        style: TextStyles.semiBold16
                            .copyWith(color: AppColors.secondaryColor)),
                    Text('الكمية المتاحة : ${productEntity.productQuantity} كرتونة',
                        style: TextStyles.semiBold16),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
