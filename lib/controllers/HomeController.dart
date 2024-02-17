import 'package:app/models/AdBanner.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';
import 'package:app/services/local_service/local_ad_banner_service.dart';
import 'package:app/services/local_service/local_category_service.dart';
import 'package:app/services/local_service/local_product_service.dart';
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
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();
    getBanners();
    getPopularCategory();
    getPopularProduct();
    super.onInit();
  }

  void getBanners() async {
    try {
      isBannerLoading(true);
      if (_localAdBannerService.getAdBanners().isNotEmpty) {
        bannerList.addAll(_localAdBannerService.getAdBanners());
      }
      var result = await RemoteBannerService().get();
      if (result != null) {
        bannerList.assignAll(abBannerFromJson(result.body as String));
        _localAdBannerService.assignAdBanners(
            adBanners: abBannerFromJson(result.body as String));
      }
    } finally {
      print('banner ${bannerList.length}');
      isBannerLoading(false);
    }
  }

  void getPopularCategory() async {
    try {
      isPopularCategoryLoading(true);
      if (_localCategoryService.getCategories().isNotEmpty) {
        popularCategoryList.addAll(_localCategoryService.getCategories());
      }
      var res = await RemotePopularCategoryService().get();
      if (res != null) {
        popularCategoryList
            .assignAll(popularCategoryListFromJson(res.body as String));
        _localCategoryService.assignAllCategories(
            categories: popularCategoryListFromJson(res.body as String));
      }
    } finally {
      print('category: ${popularCategoryList.length}');
      isPopularCategoryLoading(false);
    }
  }

  void getPopularProduct() async {
    try {
      isPopularProductLoading(true);
      if (_localProductService.getAllProducts().isNotEmpty) {
        popularProductList.addAll(_localProductService.getAllProducts());
      }
      var res = await RemotePopularProductService().get();
      if (res != null) {
        popularProductList
            .assignAll(popularProductListFromJson(res.body as String));

        _localProductService.assignAllProducts(
            categories: popularProductListFromJson(res.body as String));
      }
    } finally {
      print('product ${popularProductList.length}');
      isPopularProductLoading(false);
    }
  }
}
