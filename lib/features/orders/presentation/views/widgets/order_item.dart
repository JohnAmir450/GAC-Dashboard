import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/order_items_list_view.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/order_status.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/order_user_details.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderItemWidget({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Colors.white,
        elevation: 4,
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Price
              OrderStatus(orderEntity: orderEntity),
              Text(
                'اجمالي مبلغ الطلبية :  جنيه ${orderEntity.totalPrice.toStringAsFixed(2)}',
                style: TextStyles.bold16,
              ),
              verticalSpace(8),

              // User ID
              OrderUserDetails(orderEntity: orderEntity),
              OrderItemsListView(orderEntity: orderEntity),
              verticalSpace(16)
            ],
          ),
        ),
      ),
    );
  }
}

