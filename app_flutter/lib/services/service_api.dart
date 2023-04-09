import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_sever/configDB/config.dart';
import 'package:flutter_sever/models/product.dart';
import 'package:flutter_sever/models/category.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  static Future<List<Product>> getProductList() async {
    var products = await http.get(
      Uri.parse(configGetAllproduct),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = json.decode(products.body);
    List<Product> itemProduct = [];
    jsonResponse.forEach((item) => {
          itemProduct.add(
            Product.fromJson(item),
          )
        });
    return itemProduct;
    //làm theo cách trên hoặc dưới đều được
    // return jsonResponse.map((job) => Product.fromJson(job)).toList();
  }

  static Future<List<CategoryItem>> getCategoryList() async {
    var category = await http.get(
      Uri.parse(configGetAllCategory),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = json.decode(category.body);
    List<CategoryItem> itemCategory = [];
    jsonResponse.forEach((item) => {
          itemCategory.add(
            CategoryItem.fromJson(item),
          )
        });
    return itemCategory;
    //làm theo cách trên hoặc dưới đều được
    // return jsonResponse.map((job) => Product.fromJson(job)).toList();
  }
}
