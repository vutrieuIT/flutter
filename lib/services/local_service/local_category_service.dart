import 'package:app/models/category.dart';
import 'package:hive/hive.dart';

class LocalCategoryService {
  late Box<Category> _categoryBox;

  Future<void> init() async {
    _categoryBox = await Hive.openBox<Category>('Categories');
  }

  Future<void> assignAllCategories({required List<Category> categories}) async {
    await _categoryBox.clear();
    await _categoryBox.addAll(categories);
  }

  List<Category> getCategories() => _categoryBox.values.toList();
}