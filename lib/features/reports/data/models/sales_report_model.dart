import 'package:gac_dashboard/features/orders/domain/entities/checkout_product_details.dart';
import 'package:gac_dashboard/features/reports/data/entities/sales_report_entity.dart';

class SalesReportModel {
  final String date;
  final String productName;
  final String productCode;
  final int quantity;
  final double price;

  SalesReportModel({
    required this.date,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.price,
  });

  factory SalesReportModel.fromJson(Map<String, dynamic> json) {
    return SalesReportModel(
      date: json['date'],
      productName: json['productName'],
      productCode: json['productCode'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  toMap(){
    return {
      'date': date,
      'productName': productName,
      'productCode': productCode,
      'quantity': quantity,
      'price': price,
    };
  }
  
    factory SalesReportModel.fromOrderEntity(CheckoutProductDetails  entity,String date) {
      return SalesReportModel(
        date: date,
        productName: entity.productName,
        productCode: entity.productCode,
        quantity: entity.productQuantity,
        price: entity.productPrice,
      );
      
    }
  factory SalesReportModel.fromEntity(SalesReportEntity entity) {
    return SalesReportModel(
      date: entity.date,
      productName: entity.productName,
      productCode: entity.productCode,
      quantity: entity.quantity,
      price: entity.price,
    );
  }
}