import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/presentation/views/data/models/shipping_address_model.dart';


class OrderModel {
 final String notificationId; 
  final String uID;
  final Timestamp orderDate;
  final double totalPrice;
  final String orderStatus;
  final bool? payWithCash;
  final String orderId;
  final ShippingAddressModel shippingAddressModel;
  final List<CheckoutProductDetails> checkoutProductDetailsList;

  OrderModel(
      {required this.uID,
      required this.orderDate,
      required this.notificationId,
      required this.totalPrice,
      required this.payWithCash,
      this.orderStatus = 'جاري التأكيد',
      required this.orderId,
      required this.shippingAddressModel,
      required this.checkoutProductDetailsList});
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      uID: json['uID'],
      orderDate: json['orderDate'],
      totalPrice: json['totalPrice'],
      payWithCash: json['payWithCash'] ?? true,
      orderStatus: json['orderStatus'],
      orderId: json['orderId'],
      notificationId: json['notificationId'],
      
      shippingAddressModel:
          ShippingAddressModel.fromJson(json['shippingAddressModel']),
      checkoutProductDetailsList: (json['checkoutProductDetailsList']
              as List<dynamic>)
          .map(
              (e) => CheckoutProductDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
 
 OrderEntity toEntity(){
   return OrderEntity(
     uID: uID,
     notificationId: notificationId,
     orderDate: orderDate,
     totalPrice: totalPrice,
     payWithCash: payWithCash,
     orderStatus: orderStatus,
     orderId: orderId,
     shippingAddressEntity: shippingAddressModel.toEntity(),
     checkoutProductDetails: checkoutProductDetailsList.toList(),
   );
 }

  toJson() {
    return {
      'uID': uID,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'payWithCash': payWithCash,
      //'notificationId': pushId,
      'orderStatus': orderStatus,
      'orderId': orderId,
      'shippingAddressModel': shippingAddressModel.toJson(),
      'checkoutProductDetailsList':
          checkoutProductDetailsList.map((e) => e.toJson()).toList()
    };
  }
}