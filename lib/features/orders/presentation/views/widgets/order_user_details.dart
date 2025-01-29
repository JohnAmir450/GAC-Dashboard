import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/helper_functions/formated_date.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';

class OrderUserDetails extends StatelessWidget {
  const OrderUserDetails({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اسم العميل: ${orderEntity.shippingAddressEntity.customerName}',
          style: TextStyles.regular14.copyWith(color: Colors.grey),
        ),
        verticalSpace(8),
        Text(
          'رقم هاتف العميل: ${orderEntity.shippingAddressEntity.customerPhone}',
          style: TextStyles.regular14.copyWith(color: Colors.grey),
        ),
        verticalSpace(8),
        Text(
          '  تاريخ الطلب: ${formatOrderDateFromTimestamp(orderEntity.orderDate)}',
          style: TextStyles.regular14.copyWith(color: Colors.grey),
        ),
        verticalSpace(8),
        // Shipping Address
        const Text(
          'عنوان التوصيل:',
          style: TextStyles.bold16,
        ),
        Text(
          orderEntity.shippingAddressEntity.toString(),
          style:TextStyles.regular14,
        ),
        verticalSpace(8),
        
        // Payment Method
        Text(
          ' طريقة الدفع: ${orderEntity.payWithCash! ? 'نقدا' : 'نقدا'}',
          style: TextStyles.regular14.copyWith(color: Colors.grey),
        ),
        verticalSpace(16),
        
        // Order Products
        const Text(
          'الطلبية:',
          style: TextStyles.bold16,
        ),
      ],
    );
  }
}

