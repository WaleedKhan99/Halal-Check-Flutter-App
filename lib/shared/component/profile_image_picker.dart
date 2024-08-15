import 'dart:io';
import 'package:flutter/material.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/component/bottomsheets/image_source_selection_bottomsheet.dart';
import 'package:halal_check/shared/component/custom_image_widget.dart';
import '../../app_constants/image_constant.dart';

class ProfileImagePickerWidget extends StatefulWidget {
  final File? image;
  final Function(File) onChange;
  const ProfileImagePickerWidget(
      {super.key, this.image, required this.onChange});

  @override
  State<ProfileImagePickerWidget> createState() =>
      _ProfileImagePickerWidgetState();
}

class _ProfileImagePickerWidgetState extends State<ProfileImagePickerWidget> {
  late ValueNotifier<File?> profileImage;

  @override
  void initState() {
    super.initState();

    profileImage = ValueNotifier(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<File?>(
        valueListenable: profileImage,
        builder: (context, image, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomImageWidget(
                  height: 100,
                  width: 100,
                  radius: 1000,
                  image: image,
                  placeHolder: ImageConstant.profilePlaceHolder,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: _onTap,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                            side: const BorderSide(
                              color: Colors.white,
                            ))),
                    icon: const Icon(
                      Icons.camera_alt,
                    )),
              )
            ],
          );
        });
  }

  Future<void> _onTap() async {
    final tempImage = (await DI.i<NavigationService>().showBottomsheet(
        title: 'Select image source',
        subTitle: 'Select image source for your profile image',
        child: const ImageSourceSelectionBottomSheet(
          titleForCropper: 'Edit profile image',
        ))) as File?;
    if (tempImage != null) {
      profileImage.value = tempImage;
      widget.onChange(tempImage);
    }
  }
}
