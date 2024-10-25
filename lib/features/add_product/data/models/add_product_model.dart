import 'dart:io';
import 'package:gac_dashboard/features/add_product/data/models/reviews_model.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/add_product_entity.dart';

class AddProductModel {
  final String name;
  final num price;
  final String description;
  final String code;
  File? fileImage;
  final bool isFeatured;
  String? imageUrl;
  final int expirationMonths;
   bool isOrganic=true;
  final int productQuantity;
  final int numberOfCalories;
   num avgRating=0;
   num ratingCount=0;
  final List<ReviewModel>reviews;

  AddProductModel({
    required this.numberOfCalories,
    required this.expirationMonths,
    required this.isOrganic,
    required this.productQuantity,
    required this.name,
    required this.price,
    required this.description,
    required this.code,
    this.fileImage,
    required this.isFeatured,
    this.imageUrl,
    required this.reviews,
  });

  factory AddProductModel.fromEntity( AddProductEntity addProductEntity) {
    return AddProductModel(
      name: addProductEntity.name,    
      price: addProductEntity.price,
      description: addProductEntity.description,
      code: addProductEntity.code,
      fileImage: addProductEntity.fileImage,  
      isFeatured: addProductEntity.isFeatured,
      imageUrl: addProductEntity.imageUrl,      
      expirationMonths: addProductEntity.expirationMonths,
      isOrganic: addProductEntity.isOrganic,
      productQuantity: addProductEntity.productQuantity,
      numberOfCalories: addProductEntity.numberOfCalories,
      reviews: addProductEntity.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
    );
  } 

  toJson(){
    return {
      'name': name,
      'price': price,
      'description': description,
      'code': code,
      'fileImage': fileImage!.path,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationMonths': expirationMonths,
      'isOrganic': isOrganic,
      'productQuantity': productQuantity,
      'numberOfCalories': numberOfCalories,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}