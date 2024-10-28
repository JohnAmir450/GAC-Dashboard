import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';

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
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(productEntity.imageUrl!))),
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
