import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.populateCategoryFromJson(Map<String, dynamic> data) =>
      Category(
          id: data['id'],
          name: data['attributes']['category']['data']['attributes']['name'],
          image: data['attributes']['category']['data']['attributes']['image']
              ['data']['attributes']['url']);
}

List<Category> popularCategoryListFromJson(String val) =>
    List<Category>.from(jsonDecode(val)['data']
        .map((category) => Category.populateCategoryFromJson(category)));
