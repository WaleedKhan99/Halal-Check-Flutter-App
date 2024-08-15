import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halal_check/domain/authentication/auth_repository.dart';
import 'package:halal_check/domain/authentication/models/app_user_model.dart';
import 'package:halal_check/domain/authentication/models/authDTO.dart';
import 'package:halal_check/domain/authentication/models/loginDTO.dart';
import 'package:halal_check/domain/authentication/models/shop_detail_DTO.dart';
import 'package:halal_check/domain/shop_details/model/shop_timing_model.dart';
import 'package:halal_check/provider/home_provider.dart';
import 'package:halal_check/screens/home_screen/home_screen.dart';
import 'package:halal_check/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:halal_check/screens/registration/shop_detail_screen.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/firebase_auth_services.dart';
import 'package:halal_check/services/navigation_services.dart';

import '../screens/authentication/otp_screen.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();
  final AuthRepository _authRepository = AuthRepository();

  NavigationService _navService = DI.i<NavigationService>();

  FirebaseAuthServices get fbAuth => _authServices;

  AppUserModel? appUser;

  User? get currentUser => _authServices.user;

  bool get isUserLogedIn => currentUser != null && appUser != null;

  logout() {
    _authServices.logout.then((value) {
      appUser = null;
      notifyListeners();
    });
  }

  Future<bool> loadUser() async {
    return await Future.delayed(const Duration(seconds: 5), () async {
      if (fbAuth.user != null) {
        appUser = await _authRepository.getUserData(currentUser?.uid ?? '');
        notifyListeners();
        _navService.navigateTo((context) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
        return true;
      } else {
        _navService.navigateTo((context) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
        });
        return false;
      }
    });
  }

  Future<bool> loginWithAuthCredentials(LoginDTO dto) async {
    final response = await _authServices.loginWithEmailPassword(dto);
    try {
      if (response != null) {
        appUser = await _authRepository.getUserData(currentUser?.uid ?? '');
        DI.i<HomeScreenProvider>().toggleDrawer();
        notifyListeners();
        _navService.navigateTo((context) => Navigator.pop(context));
        _navService.showSnackBar(message: 'Login sucessfull');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> checkCredentialAvailablityAndVerifyPhone({
    required AuthDto dto,
    required bool isShowOwner,
    required ValueNotifier<bool> loader,
  }) async {
    _authRepository.checkCredentials(dto).then((value) {
      if (value) {
        if (isShowOwner) {
          loader.value = false;
          _navService.navigateTo((context) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ShopDetailRegistrationScreen(
                dto: dto,
              );
            }));
          });
        } else {
          sentVerificationCode(dto: dto, loader: loader, isShowOwner: isShowOwner);
        }
      } else {
        loader.value = false;
      }
    });
  }

  sentVerificationCode({
    required AuthDto dto,
    ShopDetailDTO? shopDto,
    bool isShowOwner = false,
    ShopTimingModel? timingModel,
    required ValueNotifier<bool> loader,
  }) async {
    _authServices.verifyPhoneNumber(
      dto: dto,
      verificationFailed: (error) {
        loader.value = false;
      },
      codeSent: () {
        loader.value = false;
        _navService.navigateTo(
          (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OTPScreen(
                    dto: dto,
                    shopDto: shopDto,
                    timingModel: timingModel,
                  );
                },
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (value) {},
    );
  }

  Future<void> resendVerificationCode({
    required AuthDto dto,
    ValueNotifier<bool>? loader,
    required Function() startTimer,
  }) async {
    _authServices.verifyPhoneNumber(
        dto: dto,
        verificationFailed: (error) {
          loader?.value = false;
        },
        codeSent: () {
          loader?.value = false;
          startTimer();
        },
        codeAutoRetrievalTimeout: (value) {});
  }

  Future<bool> verifySmsCode(
    AuthDto dto,
    String smsCode,
    ShopDetailDTO? shopDto,
    ShopTimingModel? timingModel,
  ) async {
    try {
      final userCred = await _authServices.verifyCode(dto, smsCode);
      if (userCred != null) {
        bool profileCreationResponse = false;
        if (shopDto == null) {
          profileCreationResponse = await _authRepository.createNewUser(
            dto,
            currentUser?.uid ?? '',
          );

          appUser = await _authRepository.getUserData(
            currentUser?.uid ?? '',
          );
        } else {
          profileCreationResponse = await _authRepository.createShop(
            dto: dto,
            shopDto: shopDto,
            shopTiming: timingModel!,
            uid: currentUser?.uid ?? '',
          );
          appUser = await _authRepository.getUserData(
            currentUser?.uid ?? '',
          );
        }
        if (profileCreationResponse) {
          _navService.navigateTo((context) async {
            Navigator.pop(context);
            Navigator.pop(context);
            if (shopDto != null) {
              Navigator.pop(context);
            }

            DI.i<HomeScreenProvider>().toggleDrawer();
            notifyListeners();
          });

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
