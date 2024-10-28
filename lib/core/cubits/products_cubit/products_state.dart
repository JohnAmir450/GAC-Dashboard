part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitialState extends ProductsState {}

final class ProductsLoadingState extends ProductsState {}
final class ProductsSuccessState extends ProductsState {
  final List<ProductEntity>products;

  ProductsSuccessState({required this.products});
}
final class ProductsFailureState extends ProductsState {
  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}

