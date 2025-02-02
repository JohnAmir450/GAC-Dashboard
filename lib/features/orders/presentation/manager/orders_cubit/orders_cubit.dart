import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:gac_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;
  OrdersCubit(this.ordersRepo) : super(OrdersInitialState());

  Future<void> getOrder(
      {Map<String, dynamic>? query,
      List<Map<String, dynamic>>? whereConditions}) async {
    emit(GetOrdersLoadingState());

    var result = await ordersRepo.getOrders(
        query: query,
        whereConditions: whereConditions
       );

    result.fold((failure) {
      emit(GetOrdersFailureState(errorMessage: failure.message));
    }, (orders) {
      emit(GetOrdersSuccessState(orders: orders));
    });
  }

  Future<void> updateProductStatus(
      {required String orderId, required String status}) async {
        
    await ordersRepo.updateOrderStatus(orderId: orderId, status: status);

  }

  Future<void> deleteOrder({required String orderId}) async {
    await Future.delayed(const Duration(days: 2));

    await ordersRepo.deleteOrder(orderId: orderId);
  }

  Future<void> updateProductQuantityIfCancelled({
    required String orderId,
    required List<CheckoutProductDetails> products,
  }) async {
    await ordersRepo.updateProductQuantityIfCancelled(
      orderId: orderId,
      products: products,
    );
    await ordersRepo.updateProductSellingCountIfCancelled(
      orderId: orderId,
    );
  }


}
