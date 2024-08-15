class AppUserEntity {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final bool isShopOwner;

  AppUserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.isShopOwner,
  });
  factory AppUserEntity.fromJson(Map<String, dynamic> json) {
    return AppUserEntity(
        uid: json['uid'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        profileImageUrl: json['profileImageUrl'] ?? '',
        isShopOwner: json['isShopOwner'] ?? false);
  }
}
