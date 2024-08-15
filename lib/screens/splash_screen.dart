import 'package:flutter/material.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:lottie/lottie.dart';

import '../provider/authentication_provider.dart';

class SplashScreen extends StatefulWidget {
  static String route = '/';
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    DI.i<AuthenticationProvider>().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstantLight.secondary,
      body: Center(
        child: Lottie.asset(
          repeat: false,
          ImageConstant.halallight,
        ),
      ),
    );
  }
}
