import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/provider/home_provider.dart';
import 'package:halal_check/screens/home_screen/home_screen.dart';
import 'package:halal_check/screens/registration/user_registration_screen.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/component/bottomsheets/user_type_selection_bottomsheet.dart';
import 'package:halal_check/shared/widget/shared_widget.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app_constants/icons_constants.dart';
import '../../app_constants/image_constant.dart';
import 'widgets/onboarding_pages.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String subTitle;

  const OnboardingModel(
      {required this.image, required this.title, required this.subTitle});
}

final onboardingListing = List.generate(
  3,
  (index) => OnboardingModel(
    image: [
      ImageConstant.onboarding_1,
      ImageConstant.onboarding_2,
      ImageConstant.onboarding_3,
    ][index],
    title: 'Lorem ipsum, dolor sit amet!',
    subTitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
  ),
);

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPageIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateForward() {
    if (_currentPageIndex < 2) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
      setState(() {
        _currentPageIndex++;
      });
    } else {
      DI.i<NavigationService>().showBottomsheet(
          title: 'Chose User Type',
          subTitle: 'Chose the user type you want to register as',
          child: UserTypeSelectionBottomSheet(
            onUserTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
            onShopTap: () async {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));

              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const UserRegistrationScreen(
                  isShopOwner: true,
                );
              }));
              DI.i<HomeScreenProvider>().toggleDrawer();
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: SizedBox(
                height: 0.74.sh,
                child: PageView.builder(
                  itemCount: onboardingListing.length,
                  scrollDirection: Axis.horizontal,
                  // =========== This below line is comment, because it stop swipe functionality ===========
                  // physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingPage(
                    data: onboardingListing[index],
                  ),
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: onboardingListing.length,
              effect: ExpandingDotsEffect(
                  dotHeight: 6.h,
                  dotWidth: 6.w,
                  dotColor: Colors.grey,
                  activeDotColor: ColorConstantLight.primary),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_currentPageIndex > 0)
                    TextButton(
                      onPressed: () => _controller.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear,
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                      ),
                    ),
                  const Spacer(),
                  CustomGradientIconButton(
                    text: 'Get Started',
                    showIcon: _currentPageIndex != 2,
                    iconPath: IconsConstant.forwararrow,
                    elevation: false,
                    onPressed: _navigateForward,
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
