// ignore_for_file: pu
import 'dart:io';

class AuthDto {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final File? profileImage;

  AuthDto(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.profileImage});

  Map<String, dynamic> toMap({
    required String url,
    required String uid,
    String? shopId,
  }) {
    final data = <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profileImageUrl': url,
    };
    if (shopId != null) {
      data['shopId'] = [shopId];
      data['isShopOwner'] = true;
    }

    return data;
  }
}
