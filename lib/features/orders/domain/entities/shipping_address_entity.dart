class ShippingAddressEntity {
   String? customerName;
   String? customerPhone;
   String? customerEmail;
   String? customerGovernment;
   String? customerCity;
   String? customerStreetName;
   String? customerLocationDescription;

  ShippingAddressEntity({
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
}