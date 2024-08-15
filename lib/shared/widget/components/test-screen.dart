import 'package:flutter/material.dart';
import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/shared/widget/components/app-bar-components/map_button.dart';
import 'package:halal_check/shared/widget/components/app-bar-components/share_button.dart';
import 'package:halal_check/shared/widget/components/body-components/list_card.dart';
import 'package:halal_check/shared/widget/components/body-components/review_card.dart';
import 'package:halal_check/shared/widget/components/body-components/review_overall_rating.dart';
import 'package:halal_check/shared/widget/custom_divider.dart';
import 'package:halal_check/shared/widget/custom_icon_button.dart';
import 'package:halal_check/shared/widget/custom_text.dart';

import 'app-bar-components/custom_search_bar.dart';
import 'body-components/carousel_slider_widget.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: const Center(
            child: Text(
              "Components Test Screen",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      MapButton(
                        onTap: () {},
                      ),
                      const SizedBox(height: 20, width: 10),
                      ShareButton(onTap: () {}),
                      const SizedBox(height: 20, width: 10),
                      CustomIconButton(
                          icon: IconsConstant.backarrow, onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomDivider(),
                  const SizedBox(height: 10),
                  const CustomSearchBar(),
                  const SizedBox(height: 20),
                  const CustomDivider(),
                  const SizedBox(height: 10),
                  CustomListCard(
                    imageUrl: ImageConstant.list_card_1,
                    rating: "4.8",
                    reviews: "(73)",
                    title: "The Elgin ",
                    description: "This cabin comes with..",
                    location: "New york, NY",
                    onRatingTap: () {},
                    onMapTap: () {},
                  ),
                  const SizedBox(height: 20),
                  const CustomDivider(),
                  const SizedBox(height: 10),
                  ReviewCard(
                    name: "John Doe",
                    rating: "4.9",
                    description:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                    imageUrl: ImageConstant.review_image,
                    onTapRating: () {},
                    rankingnumber: '3.5',
                  ),
                  const SizedBox(height: 20),
                  const CustomDivider(),
                  const SizedBox(height: 10),
                  const HeadingText(headingtext: "Overall Rating"),
                  const SizedBox(height: 20),
                  ReviewsOverallRating(
                    ratingsData: [
                      {'rating': 4, 'progressValue': 0.8},
                      {'rating': 3, 'progressValue': 0.6},
                      {'rating': 2, 'progressValue': 0.4},
                      {'rating': 1, 'progressValue': 0.2},
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomDivider(),
                  const SizedBox(height: 10),
                  // const CarouselSliderWidget(
                  //   imageList: [
                  //     ImageConstant.card1,
                  //     ImageConstant.card2,
                  //     ImageConstant.card3,
                  //     ImageConstant.card1,
                  //     ImageConstant.card2,
                  //     ImageConstant.card3,
                  //     ImageConstant.card1,
                  //     ImageConstant.card2,
                  //     ImageConstant.card3,
                  //     ImageConstant.card1,
                  //     ImageConstant.card2,
                  //     ImageConstant.card3,
                  //   ],
                  // ),
                  CarouselSliderWidget(imageList: [
                    Image.network(
                        'https://img.freepik.com/free-photo/restaurant-interior_1127-3394.jpg?size=626&ext=jpg'),
                    Image.asset(ImageConstant.card1),
                    Image.asset(ImageConstant.card2),
                    Image.asset(ImageConstant.card3)
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
