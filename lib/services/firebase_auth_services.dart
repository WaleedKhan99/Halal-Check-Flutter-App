import 'package:firebase_auth/firebase_auth.dart';
import 'package:halal_check/domain/authentication/models/authDTO.dart';
import 'package:halal_check/domain/authentication/models/loginDTO.dart';
import 'package:halal_check/services/navigation_services.dart';

import 'di_services.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  String? _verificationID;
  int? _forceResendingToken;

  Future<void> get logout => _auth.signOut();

  Future<void> verifyPhoneNumber({
    required AuthDto dto,
    required void Function() codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(FirebaseAuthException) verificationFailed,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: dto.phoneNumber,
          verificationCompleted: (authCred) async {},
          verificationFailed: (e) {
            verificationFailed(e);
            DI.i<NavigationService>().showSnackBar(message: e.message ?? 'Something went wrong');
          },
          codeSent: (String verificationID, int? resendingToken) {
            _verificationID = verificationID;
            _forceResendingToken = resendingToken;
            DI.i<NavigationService>().showSnackBar(message: 'Check SMS for OTP');
            codeSent();
          },
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          forceResendingToken: _forceResendingToken);
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
    }
  }

  Future<UserCredential?> verifyCode(AuthDto dto, String smsCode) async {
    try {
      PhoneAuthCredential phoneCredential =
          PhoneAuthProvider.credential(verificationId: _verificationID!, smsCode: smsCode);
      final userCred = await _auth.signInWithCredential(phoneCredential);
      AuthCredential emailCredentials =
          EmailAuthProvider.credential(email: dto.email, password: dto.password);
      await _auth.currentUser!.linkWithCredential(emailCredentials);
      return userCred;
    } on FirebaseAuthException catch (e) {
      DI.i<NavigationService>().showSnackBar(message: e.message ?? '');
      print(e.message);
      return null;
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
      return null;
    }
  }

  Future<UserCredential?> loginWithEmailPassword(LoginDTO dto) async {
    try {
      final response =
          await _auth.signInWithEmailAndPassword(email: dto.email, password: dto.password);
      return response;
    } on FirebaseAuthException catch (e) {
      DI.i<NavigationService>().showSnackBar(message: e.message ?? '');
      return null;
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
      return null;
    }
  }
}
