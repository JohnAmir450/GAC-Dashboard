
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;
  final AuthRepo authRepo;
  ProductsCubit(this.productsRepo, this.authRepo) : super(ProductsInitialState());

  void getProducts({Map<String, dynamic>? query}) {
    emit(ProductsLoadingState());
    productsRepo.getProductsStream(query: query).fold((failure) {
      emit(ProductsFailureState(errorMessage: failure.message));
    }, (stream) {
      stream.listen((products) {
        emit(ProductsSuccessState(products: products));
      }, onError: (error) {
        emit(ProductsFailureState(errorMessage: error.toString()));
      });
    });
  }

  Future<void> signOut()async{
    await authRepo.signOut();
  }
}
