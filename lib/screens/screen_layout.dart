import 'package:flutter/material.dart';
import '../shared/component/full_screen_loader.dart';
import '../shared/widget/custom_app_bar.dart';

class ScreenLayout extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  final ValueNotifier<bool> loader;
  final String? loaderText;
  const ScreenLayout(
      {super.key,
      required this.appBarTitle,
      required this.body,
      required this.loader,
      this.loaderText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: CustomAppBar(
              title: appBarTitle,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: body)),
        FullScreenLoader(
          loader: loader,
          loaderText: loaderText,
        ),
      ],
    );
  }
}
