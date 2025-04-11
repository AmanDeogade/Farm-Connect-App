import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String productName;
  int productPrice;
  int quantity;
  String quantityUnit;
  String description;
  String category;
  String farmerId;
  String fullName;
  String subCategory;
  List<String> images;
  bool popular;
  bool recommend;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.quantityUnit,
    required this.description,
    required this.category,
    required this.farmerId,
    required this.fullName,
    required this.subCategory,
    required this.images,
    required this.popular,
    required this.recommend,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"] ?? "", // ✅ Default to empty string if null
    productName: json["productName"] ?? "Unknown", // ✅ Default value
    productPrice: json["productPrice"] ?? 0, // ✅ Default to 0 if null
    quantity: json["quantity"] ?? 0,
    quantityUnit: json["quantityUnit"] ?? "kg",
    description: json["description"] ?? "No description",
    category: json["category"] ?? "Unknown",
    farmerId: json["farmerId"] ?? "", // ✅ Handle missing farmerId
    fullName: json["fullName"] ?? "Unknown",
    subCategory: json["subCategory"] ?? "Unknown",
    images:
        (json["images"] != null)
            ? List<String>.from(json["images"])
            : [], // ✅ Default to empty list if null
    popular: json["popular"] ?? false, // ✅ Handle missing boolean values
    recommend: json["recommend"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "productPrice": productPrice,
    "quantity": quantity,
    "quantityUnit": quantityUnit,
    "description": description,
    "category": category,
    "farmerId": farmerId,
    "fullName": fullName,
    "subCategory": subCategory,
    "images": images,
    "popular": popular,
    "recommend": recommend,
  };
}
