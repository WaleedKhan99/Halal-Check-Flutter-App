import 'package:get_it/get_it.dart';
import 'package:halal_check/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../provider/home_provider.dart';
import 'google_apis/place_api/place_api_provider.dart';
import 'navigation_services.dart';

class DI {
  static GetIt i = GetIt.instance;

  static void initialize() {
    i.registerLazySingleton<PlaceApiProvider>(() => PlaceApiProvider());
    i.registerLazySingleton<NavigationService>(() => NavigationService());
    i.registerLazySingleton<HomeScreenProvider>(() => HomeScreenProvider());
    i.registerLazySingleton<AuthenticationProvider>(() => AuthenticationProvider());
  }
}

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeScreenProvider>(create: (context) => DI.i<HomeScreenProvider>()),
    ChangeNotifierProvider<AuthenticationProvider>(
        create: (context) => DI.i<AuthenticationProvider>()),
  ];
}
