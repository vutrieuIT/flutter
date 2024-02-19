import 'dart:convert';
import 'package:app/models/tag.dart';
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
  @HiveField(4)
  final List<Tag> tags;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.tags,
  });

  factory Product.popularProductFromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['attributes']['product']['data']['attributes']['name'],
        description: json['attributes']['product']['data']['attributes']
            ['description'],
        images: List<String>.from(json['attributes']['product']['data']
                ['attributes']['images']['data']
            .map((e) => e['attributes']['url'])),
        tags: [],
      );

  factory Product.productFromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['attributes']['name'],
        description: json['attributes']['description'],
        images: List<String>.from(json['attributes']['images']['data']
            .map((e) => e['attributes']['url'])),
        tags: List<Tag>.from(
            json['attributes']['tags']['data'].map((e) => Tag.fromJson(e))),
      );
}

List<Product> popularProductListFromJson(String val) => List<Product>.from(
    json.decode(val)['data'].map((e) => Product.popularProductFromJson(e)));

List<Product> productListFromJson(String val) => List<Product>.from(
    json.decode(val)['data'].map((e) => Product.productFromJson(e)));
