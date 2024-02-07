import 'dart:convert';

class AdBanner {
  final int id;
  final String image;

  AdBanner({required this.id, required this.image});

  factory AdBanner.fromJson(Map<String, dynamic> json) {
    return AdBanner(
      id: json['id'],
      image: json['attributes']['image']['data']['attributes']['url'],
    );
  }
}

List<AdBanner> abBannerFromJson(String str) =>
    List<AdBanner>.from(json.decode(str)['data'].map((x) => AdBanner.fromJson(x)));
