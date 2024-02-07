import 'package:app/models/category.dart';
import 'package:app/views/home/components/popular_category/popular_category_card.dart';
import 'package:flutter/material.dart';

class PopularCategory extends StatelessWidget {
  final List<Category> categories;

  const PopularCategory({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => PopularCategoryCard(
          category: categories[index],
        ),
      ),
    );
  }
}
