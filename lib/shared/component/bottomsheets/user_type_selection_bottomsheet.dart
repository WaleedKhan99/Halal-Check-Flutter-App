import 'package:flutter/material.dart';
import 'package:halal_check/app_constants/icons_constants.dart';

import 'buttonsheet_button.dart';

class UserTypeSelectionBottomSheet extends StatelessWidget {
  final Function() onUserTap, onShopTap;

  const UserTypeSelectionBottomSheet(
      {super.key, required this.onUserTap, required this.onShopTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomSheetButton(
            icon: IconsConstant.profileIcon,
            title: 'User',
            onTap: onUserTap,
          ),
          BottomSheetButton(
            icon: IconsConstant.shopIcon,
            title: 'Shop Owner',
            onTap: onShopTap,
          ),
        ],
      ),
    );
  }
}
