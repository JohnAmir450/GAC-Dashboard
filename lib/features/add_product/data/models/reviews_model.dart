import 'package:gac_dashboard/features/add_product/domain/entities/review_entity.dart';

final class ReviewModel {
  final String name;
  final String image;
  final num ratting;
  final String date;
  final String reviewDescription;

  ReviewModel(
      {required this.name,
      required this.image,
      required this.ratting,
      required this.date,
      required this.reviewDescription});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
        name: json['name'],
        image: json['image'],
        ratting: json['ratting'],
        date: json['date'],
        reviewDescription: json['reviewDescription']);
  }
  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
        name: entity.name,
        image: entity.image,
        ratting: entity.ratting,
        date: entity.date,
        reviewDescription: entity.reviewDescription);
  }

  toJson  () {
    return {
      'name': name,
      'image': image,
      'ratting': ratting,
      'date': date,
      'reviewDescription': reviewDescription,
    };
  }
}