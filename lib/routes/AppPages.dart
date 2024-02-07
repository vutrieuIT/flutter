import 'package:app/routes/AppRoutes.dart';
import 'package:app/views/dashboard/DashBoardBindding.dart';
import 'package:get/get.dart';

import '../views/dashboard/DashBoardScreen.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashBoardScreen(),
        binding: DashboardBindding(),
    ),
  ];
}