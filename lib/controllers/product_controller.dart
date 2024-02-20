import 'package:app/models/product.dart';
import 'package:app/services/remote_service/remote_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  TextEditingController searchTextEditingController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<Product> productList = List<Product>.empty(growable: true).obs;
  RxBool isProductLoading = false.obs;


  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    try {
      isProductLoading(true);
      var res = await RemoteProductService().get();
      if (res != null) {
        productList.assignAll(productListFromJson(res.body as String));
      }
    } finally {
      isProductLoading(false);
      print(productList.length);
    }
  }

  void getProductByName({required String keyword}) async {
    try {
      isProductLoading(true);
      var res = await RemoteProductService().getByName(keyword: keyword);
      if (res != null) {
        productList.assignAll(productListFromJson(res.body));
      }
    } finally {
      isProductLoading(false);

    }
  }
}