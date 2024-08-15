import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/provider/authentication_provider.dart';
import 'package:halal_check/screens/registration/user_registration_screen.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/component/custom_image_widget.dart';
import 'package:halal_check/shared/widget/custom_icon_button.dart';
import 'package:halal_check/shared/widget/custom_text.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';
import 'package:provider/provider.dart';

import '../../app_constants/icons_constants.dart';
import '../../services/di_services.dart';
import '../../shared/component/bottomsheets/user_type_selection_bottomsheet.dart';
import '../../shared/widget/custom_divider.dart';
import '../../shared/widget/menu_option.dart';
import '../authentication/login_screen.dart';
import 'shared_widgets/rounded_elevated_button.dart';

class RegisterMenu extends StatefulWidget {
  const RegisterMenu({super.key});

  @override
  State<RegisterMenu> createState() => _RegisterMenuState();
}

class _RegisterMenuState extends State<RegisterMenu> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Drawer(
        width: 260.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        backgroundColor: Colors.white,
        child: Consumer<AuthenticationProvider>(
          builder: (context, authProv, _) => SingleChildScrollView(
            physics: authProv.isUserLogedIn
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    if (authProv.isUserLogedIn)
                      Column(
                        children: [
                          DrawerHeader(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(ImageConstant.menu_header_bg),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   width: 10.w,
                                    // ),
                                    // CustomIconButton(
                                    //   icon: IconsConstant.backarrow,
                                    //   onTap: () {
                                    //     Navigator.pop(context);
                                    //   },
                                    // ),
                                    // const Spacer(),
                                    CustomImageWidget(
                                      radius: 1000,
                                      height: 80.w,
                                      width: 80.w,
                                      imageUrl: authProv.appUser!.profileImageUrl,
                                    ),
                                    // const Spacer(),
                                    // SizedBox(
                                    //   width: 54.w,
                                    // )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        authProv.appUser!.name,
                                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                      ),
                                      Text(
                                        authProv.appUser!.email,
                                        style: context.textTheme.bodySmall!
                                            .copyWith(fontSize: 12.sp, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (!authProv.isUserLogedIn)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.h, left: 17.0.w),
                              child: CustomIconButton(
                                icon: IconsConstant.backarrow,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                RoundedElevatedButton(
                                  text: 'Login',
                                  color: const Color(0xFF41B478),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginScreen()));
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedElevatedButton(
                                  text: 'Register',
                                  color: const Color(0xFF18432D),
                                  onTap: () {
                                    DI.i<NavigationService>().showBottomsheet(
                                          title: 'Chose User Type',
                                          subTitle: 'Choose the user type you want to register as',
                                          child: UserTypeSelectionBottomSheet(
                                            onUserTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const UserRegistrationScreen();
                                                  },
                                                ),
                                              );
                                            },
                                            onShopTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const UserRegistrationScreen(
                                                      isShopOwner: true,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // ========== This below Custom Divider is use as a Divider/Separation line ==========
                          SizedBox(height: 20.h),
                          const CustomDivider()
                          // ============================================================
                        ],
                      )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const MenuHeading(
                  text: 'MENU',
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (authProv.isUserLogedIn)
                  Column(
                    children: [
                      MenuOption(
                        title: "Account Info",
                        icon: IconsConstant.account_info,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      MenuOption(
                        title: "Subscriptions",
                        icon: IconsConstant.subscrition,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      MenuOption(
                        title: "Shop Info",
                        icon: IconsConstant.shop_info,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                      MenuOption(
                        title: "Payment details",
                        icon: IconsConstant.payment_info,
                        onTap: () {},
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                if (!authProv.isUserLogedIn)
                  SizedBox(
                    height: 20.h,
                  ),
                Column(
                  children: [
                    MenuOption(
                      title: "Favourites",
                      icon: IconsConstant.favouritesmenu1,
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    MenuOption(
                      title: "Settings",
                      icon: IconsConstant.settingmenu2,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    // ========== This below Custom Divider is use as a Divider/Separation line ==========
                    const CustomDivider()
                    // ============================================================
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const MenuHeading(
                  text: 'SOCIAL MEDIA',
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (!authProv.isUserLogedIn)
                  SizedBox(
                    height: 20.h,
                  ),
                Column(
                  children: [
                    MenuOption(title: "TikTok", icon: IconsConstant.tiktok, onTap: () {}),
                    SizedBox(height: 20.h),
                    MenuOption(title: "Instagram", icon: IconsConstant.insta, onTap: () {}),
                    SizedBox(height: 20.h),
                    MenuOption(title: "Website", icon: IconsConstant.global, onTap: () {})
                  ],
                ),
                if (!authProv.isUserLogedIn)
                  SizedBox(
                    height: 80.h,
                  ),
                if (authProv.isUserLogedIn) ...[
                  SizedBox(
                    height: 40.h,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      DI.i<AuthenticationProvider>().logout();
                    },
                    label: const Text(''),
                    icon: SvgPicture.asset(IconsConstant.logout),
                  ),
                ],
                Center(
                  child: Text(
                    "Version 1.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF7D7F88),
                        fontSize: 14.sp,
                        fontFamily: "Euclid",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Center(
                  child: Text(
                    "@ HalalCheck",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF7D7F88),
                        fontSize: 10.sp,
                        fontFamily: "Euclid",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
