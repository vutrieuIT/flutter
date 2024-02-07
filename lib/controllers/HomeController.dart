import 'package:app/models/AdBanner.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';
import 'package:app/services/remote_service/RemoteBannerService.dart';
import 'package:app/services/remote_service/remote_popular_category_service.dart';
import 'package:app/services/remote_service/remote_popular_product_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Category> popularCategoryList =
      List<Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;

  @override
  void onInit() {
    getBanners();
    getPopularCategory();
    getPopularProduct();
    super.onInit();
  }

  void getBanners() async {
    try {
      isBannerLoading(true);
      var result = await RemoteBannerService().get();
      if (result != null) {
        bannerList.assignAll(abBannerFromJson(result.body as String));
      }
    } finally {
      print('banner ${bannerList.length}');
      isBannerLoading(false);
    }
  }

  void getPopularCategory() async {
    try {
      isPopularCategoryLoading(true);
      var res = await RemotePopularCategoryService().get();
      if (res != null) {
        popularCategoryList
            .assignAll(popularCategoryListFromJson(res.body as String));
      }
    } finally {
      print('category: ${popularCategoryList.length}');
      isPopularCategoryLoading(false);
    }
  }

  void getPopularProduct() async {
    try {
      isPopularProductLoading(true);
      var res = await RemotePopularProductService().get();
      if (res != null) {
        popularProductList
            .assignAll(popularProductListFromJson(res.body as String));
      }
    } finally {
      print('product ${popularProductList.length}');
      isPopularProductLoading(false);
    }
  }
}
