import 'dart:io';
import 'package:gac_dashboard/features/add_product/data/models/reviews_model.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final num price;
  final String description;
  String? productType;
  final String code;
  File? fileImage;
  final bool isFeatured;
  String? imageUrl;
  final int expirationMonths;
   bool isOrganic=true;
  final int productQuantity;
  final num discountPrice;
   num avgRating=0;
   num ratingCount=0;
  final List<ReviewModel>reviews;
  final int? sellingCount;
  final String? category;

  ProductModel({
    required this.discountPrice,
    required this.expirationMonths,
    required this.category,
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
    required this.productType,
    this.sellingCount=0
  });

  factory ProductModel.fromEntity( ProductEntity addProductEntity) {
    return ProductModel(
      category: addProductEntity.category,
      name: addProductEntity.name,    
      price: addProductEntity.price,
      productType: addProductEntity.productType,
      description: addProductEntity.description,
      code: addProductEntity.code,
      fileImage: addProductEntity.fileImage,  
      isFeatured: addProductEntity.isFeatured,
      imageUrl: addProductEntity.imageUrl,      
      expirationMonths: addProductEntity.expirationMonths,
      isOrganic: addProductEntity.isOrganic,
      productQuantity: addProductEntity.productQuantity,
      discountPrice: addProductEntity.discountPrice,
      reviews: addProductEntity.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
    );
  } 
  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      name: json['name'],
      price: json['price'],
      productType: json['productType'],
      description: json['description'],
      category: json['category'],
      code: json['code'],
      fileImage: File(json['fileImage']),
      isFeatured: json['isFeatured'],
      imageUrl: json['imageUrl'],
      expirationMonths: json['expirationMonths'],
      isOrganic: json['isOrganic'],
      productQuantity: json['productQuantity'],
      discountPrice: json['discountPrice'],
      reviews: (json['reviews'] as List<dynamic>?)
        ?.map((review) => ReviewModel.fromJson(review as Map<String, dynamic>))
        .toList() ?? [],
      sellingCount: json['sellingCount'],
    );
  }
  toJson(){
    return {
      'name': name,
      'price': price,
      'category': category,
      'productType': productType,
      'description': description,
      'code': code,
      'fileImage': fileImage!.path,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationMonths': expirationMonths,
      'isOrganic': isOrganic,
      'productQuantity': productQuantity,
      'discountPrice': discountPrice,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'sellingCount':sellingCount
    };
  }

  ProductEntity toEntity(){
    return ProductEntity(
      salesCount: sellingCount??0 ,
      name: name,    
      price: price,
      category: category,
      description: description,
      productType: productType,
      code: code,
      fileImage: fileImage,  
      isFeatured: isFeatured,
      imageUrl: imageUrl,      
      expirationMonths: expirationMonths,
      isOrganic: isOrganic,
      productQuantity: productQuantity,
      discountPrice: discountPrice,
      reviews: reviews.map((e) => e.toEntity()).toList(),
    );
  }
}