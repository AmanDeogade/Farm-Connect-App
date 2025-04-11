import 'dart:convert';

Subcategory subcategoryFromJson(String str) =>
    Subcategory.fromJson(json.decode(str));

String subcategoryToJson(Subcategory data) => json.encode(data.toJson());

class Subcategory {
  String id;
  String categoryId;
  String categoryName;
  String images;
  String subCategoryName;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    required this.subCategoryName,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        images: json["images"],
        subCategoryName: json["subCategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "images": images,
        "subCategoryName": subCategoryName,
      };
}
