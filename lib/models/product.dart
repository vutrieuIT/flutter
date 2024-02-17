import 'dart:convert';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 3)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> images;

  factory Product.popularProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      name: json['attributes']['product']['data']['attributes']['name'],
      description: json['attributes']['product']['data']['attributes']
          ['description'],
      images: List<String>.from(json['attributes']['product']['data']
              ['attributes']['images']['data']
          .map((e) => e['attributes']['url'])));

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.images});
}

List<Product> popularProductListFromJson(String val) => List<Product>.from(
    json.decode(val)['data'].map((e) => Product.popularProductFromJson(e)));
