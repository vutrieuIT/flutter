import 'package:app/controllers/HomeController.dart';
import 'package:app/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:app/controllers/DashboardController.dart';

class DashboardBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
  }
}