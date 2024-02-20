import 'package:app/component/main_header.dart';
import 'package:app/controllers/Controllers.dart';
import 'package:app/views/product/components/product_grid.dart';
import 'package:app/views/product/components/product_loading_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: Obx(() {
              if (productController.productList.isNotEmpty) {
                return ProductGrid(
                  products: productController.productList,
                );
              } else {
                return const ProductLoadingGrid();
              }
            }),
          ),
        ],
      ),
    );
  }
}
