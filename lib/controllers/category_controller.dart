import 'package:app/models/category.dart';
import 'package:app/services/local_service/local_category_service.dart';
import 'package:app/services/remote_service/remote_category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  RxList<Category> categoryList = List<Category>.empty(growable: true).obs;
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  RxBool isCategoryLoading = false.obs;

  @override
  void onInit() async {
    await _localCategoryService.init();
    super.onInit();
    getCategory();
  }

  void getCategory() async {
    try {
      isCategoryLoading(true);
      if (_localCategoryService.getCategories().isNotEmpty) {
        categoryList.assignAll(_localCategoryService.getCategories());
      }
      var res = await RemoteCategoryService().get();
      if (res != null) {
        categoryList.assignAll(categoryListFromJson(res.body));
        _localCategoryService.assignAllCategories(
            categories: categoryListFromJson(res.body));
      }
    } finally {
      isCategoryLoading(false);
    }
  }
}
