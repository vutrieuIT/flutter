import 'package:app/component/main_header.dart';
import 'package:app/controllers/Controllers.dart';
import 'package:app/views/home/components/carousel_slider/CarouselLoading.dart';
import 'package:app/views/home/components/carousel_slider/carousel_slider_view.dart';
import 'package:app/views/home/components/popular_category/popular_category.dart';
import 'package:app/views/home/components/popular_category/popular_category_loading.dart';
import 'package:app/views/home/components/popular_category/popular_category_loading_card.dart';
import 'package:app/views/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Obx(() {
            if (homeController.bannerList.isNotEmpty) {
              return CarouselSliderView(bannerList: homeController.bannerList);
            } else {
              return const CarouselLoading();
            }
          }),
          const SectionTitle(title: "Popular Category"),
          Obx(() {
            if (homeController.popularCategoryList.isNotEmpty) {
              return PopularCategory(categories: homeController.popularCategoryList);
            } else {
              return const PopularCategoryLoading();
            }
          })
        ],
      ),
    );
  }
}
