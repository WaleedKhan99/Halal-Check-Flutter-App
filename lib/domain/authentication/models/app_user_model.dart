import 'package:halal_check/data/shop_detail_data.dart/entity/app_user_entity.dart';

class AppUserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final bool isShopOwner;

  AppUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.isShopOwner,
  });
  factory AppUserModel.fromEntity(AppUserEntity entity) {
    return AppUserModel(
      uid: entity.uid,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      profileImageUrl: entity.profileImageUrl,
      isShopOwner: entity.isShopOwner,
    );
  }
}
