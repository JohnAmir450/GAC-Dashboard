

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

OrderEntity getDummyOrder() {
  // Create a sample shipping address
  ShippingAddressEntity shippingAddress = ShippingAddressEntity(
     customerName: 'John Doe',
    customerPhone: '123-456-7890',
    customerGovernment: '123 Main St',
    customerStreetName: '5th Floor',
    customerCity: 'New York',
    customerEmail: 'johndoe@example.com',
  );

  // Create a sample list of order products
  List<CheckoutProductDetails> orderProducts = [
    CheckoutProductDetails(
 productPrice: 200,
      productName: 'Product A',
      productCode: 'A123',
      productImageUrl: 'https://img.freepik.com/free-photo/cola-pouring-glass_155003-3248.jpg?t=st=1737721021~exp=1737724621~hmac=44c945478e6a90150f735b346cfbc50cbe03f6c7eb964a6c40a95c9cc9a3e8ca&w=740',
      productQuantity: 2,
     
    ),
    CheckoutProductDetails(
       productPrice: 200,
      productName: 'Product A',
      productCode: 'A123',
      productImageUrl: 'https://img.freepik.com/free-photo/cola-pouring-glass_155003-3248.jpg?t=st=1737721021~exp=1737724621~hmac=44c945478e6a90150f735b346cfbc50cbe03f6c7eb964a6c40a95c9cc9a3e8ca&w=740',
      productQuantity: 2,
     
    ),
   CheckoutProductDetails(
      productName: 'Product A',
      productPrice: 200,
      productCode: 'A123',
      productImageUrl: 'https://img.freepik.com/free-photo/cola-pouring-glass_155003-3248.jpg?t=st=1737721021~exp=1737724621~hmac=44c945478e6a90150f735b346cfbc50cbe03f6c7eb964a6c40a95c9cc9a3e8ca&w=740',
      productQuantity: 2,
     
    ),
  ];

  // Calculate total price
  

  // Create and return the OrderModel
  return OrderEntity(
    orderStatus: 'Pending',
    orderId:  '12345' ,
    orderDate: Timestamp.fromDate(DateTime.now()),
    totalPrice: 1000,
    uID: 'user123',
    shippingAddressEntity: shippingAddress,
    checkoutProductDetails: orderProducts,
    payWithCash: true,
    notificationId: 'notification123',
  );
}