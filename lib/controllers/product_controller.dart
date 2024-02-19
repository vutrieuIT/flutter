import 'package:app/models/product.dart';
import 'package:app/services/remote_service/remote_product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

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
        productList.addAll(productListFromJson(res.body as String));
      }
    } finally {
      isProductLoading(false);
      print(productList.length);
    }
  }
}