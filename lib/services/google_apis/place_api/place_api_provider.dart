// import 'package:flutter/material.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:halal_check/services/extensions.dart';

// import 'place_api_networking.dart';

// class PlaceApiProvider with ChangeNotifier {
//   final _placeApiNetworking = PlaceApiNetworking();
//   bool get isLoading => _isLoading;
//   bool _isLoading = false;

//   List<Prediction> get predictions => _predictions;
//   final List<Prediction> _predictions = [];

//   void placeAutoCompete(String vl) async {
//     _isLoading = true;
//     notifyListeners();

//     final tempPredictions = await _placeApiNetworking.placeAutoCompete(vl);
//     if (tempPredictions.isNotNullOrEmpty) {
//       _predictions.clear();
//       _predictions.addAll(tempPredictions!);
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

// =================================================================

import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:halal_check/services/extensions.dart';

import 'place_api_networking.dart';

class PlaceApiProvider with ChangeNotifier {
  final _placeApiNetworking = PlaceApiNetworking();
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<Prediction> get predictions => _predictions;
  final List<Prediction> _predictions = [];

  // Create a ValueNotifier to wrap the predictions list
  final ValueNotifier<List<Prediction>> _predictionsNotifier =
      ValueNotifier<List<Prediction>>([]);
  ValueNotifier<List<Prediction>> get predictionsNotifier =>
      _predictionsNotifier;

  void placeAutoCompete(String vl) async {
    _isLoading = true;
    notifyListeners();

    final tempPredictions = await _placeApiNetworking.placeAutoCompete(vl);
    if (tempPredictions.isNotNullOrEmpty) {
      _predictions.clear();
      _predictions.addAll(tempPredictions!);
      // Update the ValueNotifier with the new predictions
      _predictionsNotifier.value = _predictions;
    }

    _isLoading = false;
    notifyListeners();
  }
}
