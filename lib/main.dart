import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/screens/splash_screen.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/theme/custom_theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  DI.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: DI.i<NavigationService>().navigationKey,
          theme: CustomThemeData.getThemeData(isDark: false),
          home: const SplashScreen(),
          // home: TestScreen(),
        ),
      ),
    );
  }
}
