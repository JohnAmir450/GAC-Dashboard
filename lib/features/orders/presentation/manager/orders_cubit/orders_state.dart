part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitialState extends OrdersState {}

final class GetOrdersSuccessState extends OrdersState {
  final List<OrderEntity>orders;

  GetOrdersSuccessState({required this.orders});
}

final class GetOrdersFailureState extends OrdersState {
  final String errorMessage;

  GetOrdersFailureState({required this.errorMessage});
}

final class GetOrdersLoadingState extends OrdersState {}
