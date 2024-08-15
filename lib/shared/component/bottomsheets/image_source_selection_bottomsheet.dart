import 'package:flutter/material.dart';
import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/shared/component/bottomsheets/buttonsheet_button.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/helper_function.dart';

class ImageSourceSelectionBottomSheet extends StatelessWidget {
  final String titleForCropper;
  final bool showCropper, pickFile;

  const ImageSourceSelectionBottomSheet({
    super.key,
    required this.titleForCropper,
    this.showCropper = true,
    this.pickFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomSheetButton(
            title: 'Camera',
            icon: IconsConstant.cameraIcon,
            onTap: () {
              pickImage(context: context, source: ImageSource.camera);
            },
          ),
          BottomSheetButton(
            title: 'Gallery',
            icon: IconsConstant.galleryIcon,
            onTap: () {
              pickImage(context: context, source: ImageSource.gallery);
            },
          ),
          if (pickFile)
            BottomSheetButton(
              title: 'Pick files',
              icon: IconsConstant.fileIcon,
              onTap: () {
                _pickFile(context: context);
              },
            ),
        ],
      ),
    );
  }

  pickImage({required BuildContext context, required ImageSource source}) {
    HelperFunction.pickProfileImage(
            source: source, title: titleForCropper, showPicker: showCropper)
        .then((image) {
      if (image != null) {
        Navigator.pop(context, image);
      }
    });
  }

  _pickFile({required BuildContext context}) {
    HelperFunction.pickFile().then((file) {
      if (file != null) {
        Navigator.pop(context, file);
      }
    });
  }
}

class BottomSheetTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  const BottomSheetTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(icon),
        title: Text(title, style: context.textTheme.bodyLarge),
        onTap: onTap);
  }
}
