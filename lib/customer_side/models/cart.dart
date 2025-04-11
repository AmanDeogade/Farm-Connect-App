import 'dart:convert';

class Cart {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String farmerId;
  final int productQuantity;
  int quantity;
  final String productId;
  final String quantityUnit;
  final String description;
  final String fullName;

  Cart({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.image,
    required this.farmerId,
    required this.productQuantity,
    required this.quantity,
    required this.quantityUnit,
    required this.productId,
    required this.description,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'image': image,
      'farmerId': farmerId,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'quantityUnit': quantityUnit,
      'productId': productId,
      'description': description,
      'fullName': fullName,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      image: List<String>.from((map['image'] as List<dynamic>)),
      farmerId: map['farmerId'] as String,
      productQuantity: map['productQuantity'] as int,
      quantity: map['quantity'] as int,
      quantityUnit: map['quantityUnit'] as String,
      productId: map['productId'] as String,
      description: map['description'] as String,
      fullName: map['fullName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
