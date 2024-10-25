part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitialState extends AddProductState {}

final class AddProductLoadingState extends AddProductState {}

final class AddProductSuccessState extends AddProductState {}

final class AddProductFailureState extends AddProductState {
  final String errorMessage;

  AddProductFailureState({required this.errorMessage});
}
