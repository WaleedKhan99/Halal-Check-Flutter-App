import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/provider/mode_provider.dart';
import 'package:provider/provider.dart';

import '../../app_constants/icons_constants.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            IconsConstant.backarrow,
            width: 48.w,
            height: 48.h,
          ),
        ),
        title: Center(
            child: Text(
          "Theme",
          style: TextStyle(
              fontSize: 16.sp,
              fontFamily: "Euclid",
              fontWeight: FontWeight.w700),
        )),
      ),
      body:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text(
                "Dark",
                style: TextStyle(fontFamily: "Euclid"),
              ),
              trailing: Switch(
                  value: notifier.isDark,
                  onChanged: (value) => notifier.changeTheme()),
            )
          ],
        );
      }),
    );
  }
}
