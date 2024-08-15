import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/google_map/google_map.dart';
import 'package:halal_check/provider/home_provider.dart';
import 'package:halal_check/screens/home_screen/register_menu_screen.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/shared/widget/components/app-bar-components/custom_search_bar.dart';
import 'package:halal_check/shared/widget/custom_icon_button.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'shared_widgets/resturant_card.dart';
import 'shared_widgets/resturant_model.dart';

final restaurantList = List.generate(
    3,
    (index) => RestaurantModel(
        imageUrl: [
          ImageConstant.card1,
          ImageConstant.card2,
          ImageConstant.card3,
        ][index],
        name:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, consectetur adipiscing elit, consectetur adipiscing elit",
        description:
            'Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elit',
        rating: 3.7,
        reviews: 67,
        coordinates: const LatLng(40.7128, -74.0060),
        location: 'New York City, NYC'));

class HomeScreen extends StatefulWidget {
  static String route = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  late HomeScreenProvider homeProvider;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    homeProvider = DI.i<HomeScreenProvider>();
    // Adding markers for halal restaurants
    addMarker("1", const LatLng(40.7128, -74.0060), "Halal Restaurant 1",
        "Description of Restaurant 1");
    addMarker("2", const LatLng(40.7306, -73.9352), "Halal Restaurant 2",
        "Description of Restaurant 2");
    addMarker("3", const LatLng(40.7580, -73.9855), "Halal Restaurant 3",
        "Description of Restaurant 3");
  }

  addMarker(String id, LatLng location, String title, String snippet) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: title, snippet: snippet));

    _markers[id] = marker;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: DI.i<HomeScreenProvider>().scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: const RegisterMenu(),
      drawerScrimColor: ColorConstantLight.secondary.withOpacity(0.67),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            google_map(),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImageConstant.halalCheckLogo,
                              width: 50, // Adjust width as needed
                              height: 50, // Adjust height as needed
                            ),
                            CustomIconButton(
                              icon: IconsConstant.menuIcon,
                              onTap: () {
                                DI.i<HomeScreenProvider>().toggleDrawer();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // =========== Using custom search bar widget ===========
                        CustomSearchBar(),
                        // ======================================================
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 0.43.sh,
                    child: ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                              width: 20.w,
                            ),
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(data: restaurantList[index]);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
