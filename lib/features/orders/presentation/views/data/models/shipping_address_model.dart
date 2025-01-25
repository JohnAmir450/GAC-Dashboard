
import 'package:gac_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
   String? customerName;
   String? customerPhone;
   String? customerEmail;
   String? customerGovernment;
   String? customerCity;
   String? customerStreetName;
   String? customerLocationDescription;

  ShippingAddressModel({
     this.customerName,
     this.customerPhone,
     this.customerEmail,
     this.customerGovernment,
     this.customerCity,
     this.customerStreetName,
    this.customerLocationDescription,
  });
 
  @override
  String toString() {
    return '$customerGovernment, $customerCity, $customerStreetName,';
    
  }

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerEmail: json['customerEmail'],
      customerGovernment: json['customerGovernment'],
      customerCity: json['customerCity'],
      customerStreetName: json['customerStreetName'],
      customerLocationDescription: json['customerLocationDescription']
    );
  }
  ShippingAddressEntity toEntity(){
    return ShippingAddressEntity(
      customerName: customerName,
      customerPhone: customerPhone,
      customerEmail: customerEmail,
      customerGovernment: customerGovernment,
      customerCity: customerCity,
      customerStreetName: customerStreetName,
      customerLocationDescription: customerLocationDescription
    );
  }
  toJson(){
    return {
      'customerName': customerName ,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'customerGovernment': customerGovernment ,
      'customerCity': customerCity,
      'customerStreetName': customerStreetName,
      'customerLocationDescription': customerLocationDescription
    };
  }
}