import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

class OrderEntity {
  final String uID;
  final Timestamp orderDate;
  final List<CheckoutProductDetails>checkoutProductDetails;
  final double totalPrice;
  final bool? payWithCash;
  final String orderStatus ;
  ShippingAddressEntity shippingAddressEntity ;
  final String orderId ;
  final String notificationId;

  OrderEntity({
    required this.orderId,
    required this.uID,
    required this.orderStatus,
    required this.orderDate,
    required this.checkoutProductDetails,
    required this.totalPrice,
    this.payWithCash = true,
    required this.notificationId,
    required this.shippingAddressEntity
  });

  
}