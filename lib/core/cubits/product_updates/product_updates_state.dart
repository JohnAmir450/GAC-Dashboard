part of 'product_updates_cubit.dart';

@immutable
sealed class ProductUpdatesState {}

final class ProductUpdatesInitialState extends ProductUpdatesState {}

final class ProductUpdatesLoadingState extends ProductUpdatesState {}

final class ProductUpdatesSuccessState extends ProductUpdatesState {}

final class ProductUpdatesFailureState extends ProductUpdatesState {
  final String errorMessage;

  ProductUpdatesFailureState({required this.errorMessage});
}


final class GetProductIdLoadingState extends ProductUpdatesState {}

final class GetProductIdSuccessState extends ProductUpdatesState {}

final class GetProductIdFailureState extends ProductUpdatesState {
  final String errorMessage;

  GetProductIdFailureState({required this.errorMessage});
}




final class DeleteProductSuccessState extends ProductUpdatesState {}

final class DeleteProductFailureState extends ProductUpdatesState {
  final String errorMessage;

  DeleteProductFailureState({required this.errorMessage});
}
