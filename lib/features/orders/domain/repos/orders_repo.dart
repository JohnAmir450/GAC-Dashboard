import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    Map<String, dynamic>? query,
    List<Map<String, dynamic>>? whereConditions,
  });
  Future<Either<Failure, void>> updateOrderStatus(
      {required String orderId, required String status});

  Future<Either<Failure, void>> deleteOrder({required String orderId});
  Future<Either<Failure, void>> updateProductQuantityIfCancelled(
      {required String orderId,
      required List<CheckoutProductDetails> products,
     });

     Future<Either<Failure, void>> updateProductSellingCountIfCancelled({
    required String orderId,
     // Add the operator parameter
  });

 
}
