// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
  });

  String id;
  String name;
  String category;
  int price;
  List<String> image;
  String description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
        price: json["price"],
        image: List<String>.from(json["image"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": category,
        "price": price,
        "image": List<dynamic>.from(image.map((x) => x)),
        "description": description,
      };
}
