import 'package:app/views/home/components/popular_product/popular_product_loading_card.dart';
import 'package:flutter/material.dart';

class PopularProductLoading extends StatelessWidget {
  const PopularProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => const PopularProductLoadingCard()),
    );
  }
}
