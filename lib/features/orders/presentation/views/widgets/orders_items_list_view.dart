import 'package:flutter/material.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/order_item.dart';

class OrdersItemsListView extends StatelessWidget {
  final List<OrderEntity> orders;
  final int itemCount;
  const OrdersItemsListView({super.key,required this.orders, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => OrderItemWidget(orderEntity: orders[index],),
     separatorBuilder: (context, index) => const Divider(endIndent: 16,indent: 16,height: 30,),
      itemCount: itemCount,);
  }
}