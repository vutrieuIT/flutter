import 'package:app/models/product.dart';
import 'package:app/models/product.dart';
import 'package:app/models/product.dart';
import 'package:app/models/product.dart';
import 'package:hive/hive.dart';

class LocalProductService {
  late Box<Product> _productBox;

  Future<void> init() async {
    _productBox = await Hive.openBox<Product>('Products');
  }

  Future<void> assignAllProducts({required List<Product> categories}) async {
    await _productBox.clear();
    await _productBox.addAll(categories);
  }

  List<Product> getAllProducts() => _productBox.values.toList();
}