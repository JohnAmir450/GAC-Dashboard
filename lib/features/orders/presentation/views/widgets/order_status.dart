import 'package:flutter/material.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/custom_drop_down_button.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'حالة الطلبية: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        CustomDropDownButton(orderEntity: orderEntity,)
      ],
    );
  }
}

