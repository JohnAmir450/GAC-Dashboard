import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/widgets/custom_cached_network_image_widget.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';

class OrderItemsListView extends StatelessWidget {
  const OrderItemsListView({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderEntity.checkoutProductDetails.length,
      itemBuilder: (context, index) {
         
        final product = orderEntity.checkoutProductDetails[index];
        return ListTile(
          leading: CustomCachedNetworkImageWidget(
              borderRadius: 4, imageUrl: product.productImageUrl),
          title: Text(product.productName),
          subtitle: Text(
            'الكمية: ${product.productQuantity} كرتونة',
          ),
          trailing: Text(
            '\ جنيه ${(product.productPrice * product.productQuantity).toDouble()}',
            style: TextStyles.regular14.copyWith(color: AppColors.primaryColor),
          ),
        );
      },
    );
  }
}
