import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/helper_functions/formated_date.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_cached_network_image_widget.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/custom_drop_down_button.dart';

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
              Row(
                children: [
                  Text(
                    'حالة الطلبية: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  CustomDropDownButton(orderEntity: orderEntity,)
                ],
              ),
              Text(
                'اجمالي مبلغ الطلبية :  جنيه ${orderEntity.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              verticalSpace(8),

              // User ID
              Text(
                'اسم العميل: ${orderEntity.shippingAddressEntity.customerName}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              verticalSpace(8),
              Text(
                'رقم هاتف العميل: ${orderEntity.shippingAddressEntity.customerPhone}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              verticalSpace(8),
              Text(
                '  تاريخ الطلب: ${formatOrderDateFromTimestamp(orderEntity.orderDate)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              verticalSpace(8),
              // Shipping Address
              const Text(
                'عنوان التوصيل:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                orderEntity.shippingAddressEntity.toString(),
                style: const TextStyle(fontSize: 14),
              ),
              verticalSpace(8),

              // Payment Method
              Text(
                ' طريقة الدفع: ${orderEntity.payWithCash! ? 'نقدا' : 'نقدا'}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              verticalSpace(16),

              // Order Products
              const Text(
                'الطلبية:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.builder(
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
                      '\ جنيه ${(orderEntity.totalPrice).toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  );
                },
              ),
              verticalSpace(16)
            ],
          ),
        ),
      ),
    );
  }
}
