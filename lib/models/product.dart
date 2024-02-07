import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
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
