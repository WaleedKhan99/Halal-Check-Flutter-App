import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class FullScreenLoader extends StatelessWidget {
  final ValueNotifier<bool> loader;
  final String? loaderText;
  const FullScreenLoader({super.key, required this.loader, this.loaderText});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: loader,
        builder: (context, isLoading, _) {
          return isLoading
              ? Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      if (loaderText != null) ...[
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(loaderText!,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: Colors.white)),
                      ]
                    ],
                  ),
                )
              : const Center();
        });
  }
}
