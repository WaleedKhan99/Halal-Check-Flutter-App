import 'dart:io';

class ShopDetailDTO {
  final File logo;
  final String name;
  final String city;
  final String search;
  final String address;
  final String country;
  final String category;
  final String district;
  final File certificate;
  final String postalCode;
  final String companyName;
  final String description;
  final List<File> shopPictures;

  ShopDetailDTO({
    required this.logo,
    required this.name,
    required this.city,
    required this.search,
    required this.address,
    required this.country,
    required this.category,
    required this.district,
    required this.postalCode,
    required this.companyName,
    required this.certificate,
    required this.shopPictures,
    required this.description,
  });

  Map<String, dynamic> toMap({
    required String shopId,
    required String logoUrl,
    required String shopOwnerId,
    required String certificateUrl,
    required List<String> shopPicturesUrls,
    required Map<String, dynamic> shopOpeningHours,
  }) {
    return <String, dynamic>{
      'id': shopId,
      'name': name,
      'city': city,
      'logo': logoUrl,
      'country': country,
      'search': search,
      'address': address,
      'category': category,
      'district': district,
      'postalCode': postalCode,
      'companyName': companyName,
      'description': description,
      'shopOwnerId': shopOwnerId,
      'certificate': certificateUrl,
      'shopPicturesUrls': shopPicturesUrls,
      'shopOpeningHours': shopOpeningHours,
    };
  }
}
