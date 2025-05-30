import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/repos/images_repo/images_repo.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ImagesRepo imagesRepo;
  final ProductsRepo productsRepo;
  List<String> categories = [
    'شيف',
    'تبارك',
    'ماليزي',
    'شروق',
    'سماسم',
    'الدوار',
  ]; // Example category list
  String? selectedCategory;
  List<String>productTypes=[
    'زيوت',
    'صناعي',
    'سمن'
  ];
String? selectedProductType;
  AddProductCubit(this.imagesRepo, this.productsRepo)
      : super(AddProductInitialState());

  final TextEditingController productName = TextEditingController();
  final TextEditingController productCode = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  num? productPrice, expirationMonths, productQuantity, discountPrice;
  var formKey = GlobalKey<FormState>();
  bool isFeatured = false;
  bool isOrganic = true;
  File? productImage;

  Future<void> addProduct({required ProductEntity addProductEntity}) async {
    emit(AddProductLoadingState());
    final result =
        await imagesRepo.uploadImage(image: addProductEntity.fileImage!);

    result.fold((failure) {
      emit(AddProductFailureState(errorMessage: failure.message));
    }, (imageUrl) async {
      addProductEntity.imageUrl = imageUrl;
      final result =
          await productsRepo.addProduct(addProductEntity: addProductEntity);
      result.fold((failure) {
        emit(AddProductFailureState(errorMessage: failure.message));
      }, (success) {
        emit(AddProductSuccessState());
      });
    });
  }
}
