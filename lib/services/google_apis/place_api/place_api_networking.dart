import 'dart:convert';

import 'package:google_places_flutter/model/prediction.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/extensions.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:http/http.dart' as http;

import '../../../app_constants/contants.dart';

class PlaceApiNetworking {
  Future<List<Prediction>?> placeAutoCompete(String query) async {
    try {
      Uri url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$kGoogleAPIKey');
      // Uri url = Uri.parse(
      //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&components=country:pk');

      final response = await http.get(url);

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        PlacesAutocompleteResponse placesAutocompleteResponse =
            PlacesAutocompleteResponse.fromJson(jsonDecode(response.body));
        if (placesAutocompleteResponse.predictions.isNotNullOrEmpty) {
          return placesAutocompleteResponse.predictions!;
        }
      }
    } catch (e) {
      DI.i<NavigationService>().showToast(message: e.toString());
    }

    return null;
  }
}
