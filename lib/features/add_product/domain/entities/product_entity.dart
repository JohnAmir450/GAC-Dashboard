import 'dart:io';
import 'package:gac_dashboard/features/add_product/domain/entities/review_entity.dart';

class ProductEntity {
 
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
  final List<ReviewEntity>reviews;
  final String? category;

  ProductEntity({
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
    required this.category
  });
}