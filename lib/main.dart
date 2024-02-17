
import 'package:app/models/AdBanner.dart';
import 'package:app/models/category.dart';
import 'package:app/models/product.dart';
import 'package:app/routes/AppPages.dart';
import 'package:app/routes/AppRoutes.dart';
import 'package:app/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(AdBannerAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.list,
      initialRoute: AppRoutes.dashboard,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
