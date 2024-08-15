import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halal_check/app_constants/image_constant.dart';

LatLng currentLocation = LatLng(40.7128, -74.0060);

class google_map extends StatefulWidget {
  const google_map({Key? key}) : super(key: key);

  @override
  State<google_map> createState() => _google_mapState();
}

class _google_mapState extends State<google_map> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 12),
        onMapCreated: (controller) {
          mapController = controller;
          addMarker("Test", currentLocation);
        },
        markers: _markers.values.toSet(),
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    final imageConfiguration = createLocalImageConfiguration(context);
    final BitmapDescriptor markerImage = await BitmapDescriptor.fromAssetImage(
        imageConfiguration, ImageConstant.res_location);

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: "Elgin Resturant",
        snippet: "Best Halal Resturant of Manhattan",
      ),
      icon: markerImage,
    );

    _markers[id] = marker;
    setState(() {});
  }
}

class CustomMarker extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const CustomMarker({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: Stack(
        children: [
          // Image
          Positioned.fill(
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// ================================== Simple Google Map ==================================

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Google_Map extends StatefulWidget {
//   final onMapCreated;
//   const Google_Map({
//     super.key,
//     required this.onMapCreated,
//     required Map<String, Marker> markers,
//   }) : _markers = markers;

//   final Map<String, Marker> _markers;

//   @override
//   State<Google_Map> createState() => _Google_MapState();
// }

// class _Google_MapState extends State<Google_Map> {
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       myLocationButtonEnabled: false,
      // initialCameraPosition:
      //     CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 12),
//       onMapCreated: widget.onMapCreated,
//       markers: widget._markers.values.toSet(),
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//         Factory<OneSequenceGestureRecognizer>(
//           () => EagerGestureRecognizer(),
//         ),
//       },
//     );
//   }
// }
