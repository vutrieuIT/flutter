import 'package:app/views/home/components/popular_category/popular_category_loading_card.dart';
import 'package:flutter/material.dart';

class PopularCategoryLoading extends StatelessWidget {
  const PopularCategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => const PopularCategoryLoadingCard()),
    );
  }
}
