import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app_constants/image_constant.dart';

  class CustomImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double height, width, radius;

  /// Placeholder should be SVG file path
  final String? placeHolder;
  final BoxFit fit;
  final Color bgColor;
  final File? image;
  final bool showPlaceHolder;
  const CustomImageWidget(
      {super.key,
      this.imageUrl,
      this.image,
      this.height = 20,
      this.width = 20,
      this.radius = 0,
      this.placeHolder,
      this.fit = BoxFit.cover,
      this.showPlaceHolder = true,
      this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return (image == null)
        ? CachedNetworkImage(
            height: height,
            width: width,
            memCacheHeight: height.toInt(),
            memCacheWidth: width.toInt(),
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) {
              return _ImageContainer(
                height: height,
                width: width,
                bgColor: bgColor,
                radius: radius,
                decorationImage: showPlaceHolder
                    ? DecorationImage(
                        image: AssetImage(
                          placeHolder ?? ImageConstant.profilePlaceHolder,
                        ),
                        fit: fit)
                    : null,
              );
            },
            errorWidget: (context, url, error) {
              return _ImageContainer(
                height: height,
                width: width,
                bgColor: bgColor,
                radius: radius,
                decorationImage: showPlaceHolder
                    ? DecorationImage(
                        image: AssetImage(
                          placeHolder ?? ImageConstant.profilePlaceHolder,
                        ),
                        fit: fit)
                    : null,
              );
            },
            // progressIndicatorBuilder: (context, url, progress) {
            //   return _ImageContainer(
            //     height: height,
            //     width: width,
            //     bgColor: bgColor,
            //     radius: radius,
            //     child: const Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // },
            imageBuilder: (context, imageProvider) {
              return _ImageContainer(
                height: height,
                width: width,
                bgColor: bgColor,
                radius: radius,
                decorationImage:
                    DecorationImage(image: imageProvider, fit: fit),
              );
            },
          )
        : _ImageContainer(
            height: height,
            width: width,
            bgColor: bgColor,
            radius: radius,
            decorationImage:
                DecorationImage(image: FileImage(image!), fit: fit),
          );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    super.key,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.radius,
    this.child,
    this.decorationImage,
  });

  final double height;
  final double width;
  final Color bgColor;
  final double radius;
  final Widget? child;
  final DecorationImage? decorationImage;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: decorationImage,
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child);
  }
}
