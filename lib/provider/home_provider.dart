import 'package:flutter/material.dart';
import 'package:halal_check/screens/home_screen/shared_widgets/resturant_model.dart';

import '../services/firebase_db_services.dart';
import '../services/firestore_layer.dart';

class HomeScreenProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _firestoreLayer = FirestoreLayer();

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<RestaurantModel> get shops => _shops;
  List<RestaurantModel> _shops = [];

  Future<void> getShops() async {
    _isLoading = true;
    notifyListeners();

    ResponseGeneric res = await _firestoreLayer.makeQuery(QueryType.get, 'shops');
    if (res.success) {
      _shops = (res.data as List<dynamic>)
          .map((storeJson) => RestaurantModel.fromJson(storeJson))
          .toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  toggleDrawer() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
