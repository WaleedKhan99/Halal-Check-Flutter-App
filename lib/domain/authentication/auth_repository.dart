import 'package:halal_check/domain/authentication/models/authDTO.dart';
import 'package:halal_check/domain/authentication/models/shop_detail_DTO.dart';
import 'package:halal_check/domain/shop_details/model/shop_timing_model.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';

import '../../data/auth_db_impl.dart';
import 'models/app_user_model.dart';

class AuthRepository {
  final AuthDatabaseImpl _authDBImpl = AuthDatabaseImpl();

  Future<bool> checkCredentials(AuthDto dto) async {
    final response = await _authDBImpl.checkEmailAndPhone(dto.email, dto.phoneNumber);
    if (!response.success) {
      DI.i<NavigationService>().showSnackBar(message: response.message ?? '');
    }
    return response.success;
  }

  Future<bool> createNewUser(AuthDto dto, String uid) async {
    final response = await _authDBImpl.createUser(dto, uid);
    if (!response.success) {
      DI.i<NavigationService>().showSnackBar(message: response.message ?? '');
    } else {
      DI.i<NavigationService>().showSnackBar(message: 'Profile created Sucessfully.');
    }
    return response.success;
  }

  Future<bool> createShop({
    required String uid,
    required AuthDto dto,
    required ShopDetailDTO shopDto,
    required ShopTimingModel shopTiming,
  }) async {
    final response = await _authDBImpl.createShop(
      uid,
      dto,
      shopDto,
      shopTiming.getEntity,
    );

    if (!response.success) {
      DI.i<NavigationService>().showSnackBar(message: response.message ?? '');
    } else {
      DI.i<NavigationService>().showSnackBar(message: 'Shop created Sucessfully.');
    }
    return response.success;
  }

  Future<AppUserModel?> getUserData(String uid) async {
    try {
      final response = await _authDBImpl.getUserByUid(uid);
      if (response.success) {
        return AppUserModel.fromEntity(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
