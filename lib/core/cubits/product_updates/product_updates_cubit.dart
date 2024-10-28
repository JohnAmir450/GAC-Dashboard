import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:meta/meta.dart';

part 'product_updates_state.dart';

class ProductUpdatesCubit extends Cubit<ProductUpdatesState> {
  final ProductsRepo productsRepo;
  ProductUpdatesCubit(this.productsRepo) : super(ProductUpdatesInitialState());
  final TextEditingController? productName=TextEditingController();
final TextEditingController? productCode=TextEditingController();
final TextEditingController? productDescription=TextEditingController();
num? productPrice,expirationMonths,productQuantity,numberOfCalories;
var formKey= GlobalKey<FormState>();
bool isFeatured = false;
late String productId;

Future<void> getProductId({required dynamic field,required dynamic value})async{
  emit(GetProductIdLoadingState());
  final result=await productsRepo.getProductIdByField(field: field, value: value);
  result.fold((failure) {
    emit(GetProductIdFailureState(errorMessage: failure.message));
  }, (id) {
    productId=id;
    log(productId);
    log(id);
    emit(GetProductIdSuccessState());
    
    
  });
}

Future<void> updateProduct({required ProductEntity productEntity})async{
  emit(ProductUpdatesLoadingState());
  final result=await productsRepo.updateProduct(documentId: productId ,productEntity: productEntity);
  result.fold((failure) {
    emit(ProductUpdatesFailureState(errorMessage: failure.message));
  }, (success) {
    emit(ProductUpdatesSuccessState());
  }); 
}

  Future<void> deleteProduct()async{

    final result=await productsRepo.deleteProduct(documentId: productId);
    result.fold((failure) {
      emit(DeleteProductFailureState(errorMessage: failure.message));
    }, (success) {
      emit(DeleteProductSuccessState());
    }); 
  }
}
