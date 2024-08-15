import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantModel {
  bool isFav;
  final int reviews;
  final String name;
  final double rating;
  final String imageUrl;
  final String location;
  final String description;
  final LatLng coordinates;

  RestaurantModel({
    this.isFav = false,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.location,
    required this.coordinates,
    required this.description,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['name'],
      rating: json['rating'] ?? 0.0,
      reviews: json['reviews'] ?? 0,
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? json['logo'],
      coordinates: json['coordinates'] ?? const LatLng(40.7306, -73.9352),
    );
  }
}
