import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/core/services/database_service.dart';
import 'package:gac_dashboard/core/utils/backend_endpoints.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:gac_dashboard/features/orders/presentation/views/data/models/order_model.dart';

import '../../../../domain/entities/checkout_product_details.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;

  OrdersRepoImpl({required this.databaseService});
  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders(
      {Map<String, dynamic>? query,

     List<Map<String, dynamic>>? whereConditions
     }) async {
    try {
      List<Map<String, dynamic>> ordersData = await databaseService.getData(
          path: BackendEndpoints.orders, query: query,whereConditions: whereConditions);
      List<OrderEntity> orders =
          ordersData.map((e) => OrderModel.fromJson(e).toEntity()).toList();
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus(
      {required String orderId, required String status}) async {
    try {
      databaseService.updateProduct(
          path: BackendEndpoints.orders,
          documentId: orderId,
          data: {'orderStatus': status});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder({required String orderId}) async {
    try {
      await databaseService.deleteProduct(
          path: BackendEndpoints.orders, documentId: orderId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductQuantityIfCancelled({
    required String orderId,
    required List<CheckoutProductDetails> products,
  }) async {
    try {
      // Fetch the order document
      final orderData = await databaseService.getData(
        path: BackendEndpoints.orders,
        documentId: orderId,
      );

      if (orderData != null) {
        // Extract the product details list from the order
        final List<dynamic> productList =
            orderData['checkoutProductDetailsList'] ?? [];

        for (final product in productList) {
          final String productCode = product['code'];
          final int cancelledQuantity = product['quantity'] ?? 0;

          // Skip if cancelledQuantity is zero or invalid
          if (cancelledQuantity <= 0) continue;

          // Fetch the product document from the 'products' collection
          final productData = await databaseService.getData(
            path: BackendEndpoints.products,
            documentId: productCode,
          );

          if (productData != null) {
            // Get the current quantity of the product
            final int currentQuantity = productData['productQuantity'] ?? 0;

            // Update the product's quantity by adding the cancelled quantity
            await databaseService.updateProduct(
              path: BackendEndpoints.products,
              documentId: productCode,
              data: {
                'productQuantity': currentQuantity + cancelledQuantity,
              },
            );
          }
        }
      }

      return const Right(null);
    } catch (e) {
      print('Error updating product quantity: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
