import 'package:app/models/AdBanner.dart';
import 'package:hive/hive.dart';

class LocalAdBannerService {
  late Box<AdBanner> _adBannerBox;

  Future<void> init() async {
    _adBannerBox = await Hive.openBox<AdBanner>('AdBanners');
  }

  Future<void> assignAdBanners({required List<AdBanner> adBanners}) async {
    await _adBannerBox.clear();
    await _adBannerBox.addAll(adBanners);
  }

  List<AdBanner> getAdBanners() => _adBannerBox.values.toList();
}