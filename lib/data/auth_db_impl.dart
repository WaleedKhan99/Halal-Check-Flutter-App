import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_check/data/shop_detail_data.dart/entity/app_user_entity.dart';
import 'package:halal_check/data/shop_detail_data.dart/entity/shop_timing_entity.dart';
import 'package:halal_check/domain/authentication/models/shop_detail_DTO.dart';

import '../domain/authentication/models/authDTO.dart';
import '../services/firebase_db_services.dart';

class AuthDatabaseImpl with FirebaseServices {
  Future<ResponseGeneric> postUserData(
      Map<String, dynamic> data, String uid) async {
    return await firebaseErrorHandling(() async {
      await db.collection('users').doc(uid).set(data);
      return ResponseGeneric(
          success: true, message: 'User created sucessfully');
    });
  }

  Future<ResponseGeneric> checkEmailAndPhone(String email, String phone) async {
    return await firebaseErrorHandling(() async {
      final response = await db
          .collection('users')
          .where(Filter.or(Filter("email", isEqualTo: email),
              Filter("phoneNumber", isEqualTo: phone)))
          .get();

      if (response.docs.isEmpty) {
        return ResponseGeneric(success: true, message: 'No record Exist');
      } else {
        for (QueryDocumentSnapshot value in response.docs) {
          if (value.get('email') == email) {
            return ResponseGeneric(
                success: false, message: 'Email already Exist');
          } else {
            return ResponseGeneric(
                success: false, message: 'Phone already Exist');
          }
        }
        return ResponseGeneric(success: false, message: 'Record Exist');
      }
    });
  }

  Future<ResponseGeneric> createUser(AuthDto dto, String uid) async {
    return await firebaseErrorHandling(() async {
      final imageUrl = await storageService.uploadImage(
          imgFile: dto.profileImage, path: ['users', uid, 'profileImage']);
      await db
          .collection('users')
          .doc(uid)
          .set(dto.toMap(url: imageUrl ?? '', uid: uid));
      return ResponseGeneric(
          success: true, message: 'User created sucessfully');
    });
  }

  Future<ResponseGeneric> createShop(
    String uid,
    AuthDto dto,
    ShopDetailDTO shopDTO,
    ShopTimingEntity timingDto,
  ) async {
    return await firebaseErrorHandling(() async {
      final futures = await Future.wait<dynamic>([
        storageService.uploadImage(
          path: ['users', uid, 'profileImage'],
          imgFile: dto.profileImage,
        ),
        storageService.uploadMultipleImages(
          imageFiles: [shopDTO.certificate, shopDTO.logo],
          path: ['shop', uid, 'shopDocuments'],
          prevUrls: [],
        ),
        storageService.uploadMultipleImages(
          path: ['shop', uid, 'shopPictures'],
          imageFiles: shopDTO.shopPictures,
          prevUrls: [],
        )
      ]);
      List<String> docUrls = futures[1];
      String? imageUrl = futures[0];
      List<String> pciUrls = futures[2];

      if (imageUrl != null && docUrls.isNotEmpty && pciUrls.isNotEmpty) {
        final userDoc = db.collection('users').doc(uid);
        final shopDoc = db.collection('shops').doc();

        // ignore: unused_local_variable
        final shopTimingDoc = db
            .collection('shops')
            .doc(shopDoc.id)
            .collection('shopDetails')
            .doc('shopOpeningHours');

        await db.runTransaction<bool>((transaction) async {
          transaction.set(
            userDoc,
            dto.toMap(url: imageUrl, uid: uid, shopId: shopDoc.id),
          );
          transaction.set(
            shopDoc,
            shopDTO.toMap(
              shopOwnerId: uid,
              shopId: shopDoc.id,
              logoUrl: docUrls[1],
              shopPicturesUrls: pciUrls,
              certificateUrl: docUrls[0],
              shopOpeningHours: timingDto.toMap(),
            ),
          );
          // transaction.set(shopTimingDoc, );
          return true;
        });
      } else {
        return ResponseGeneric(success: false, message: 'Something went wrong');
      }
      return ResponseGeneric(
          success: true, message: 'User created successfully');
    });
  }

  Future<ResponseGeneric> getUserByUid(String uid) async {
    return await firebaseErrorHandling(() async {
      final response = await db.collection('users').doc(uid).get();
      late AppUserEntity entity;
      if (response.exists) {
        entity = AppUserEntity.fromJson(response.data()!);
      }
      return ResponseGeneric(success: true, data: entity);
    });
  }
}
