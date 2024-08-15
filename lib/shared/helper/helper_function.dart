import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/component/bottomsheets/image_source_selection_bottomsheet.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HelperFunction {
  static Future<void> moveAndroidAppToBackground() async {
    if (Platform.isAndroid) {
      MethodChannel androidAppRetain = const MethodChannel("android_app_retain");
      await androidAppRetain.invokeMethod("sendToBackground");
    }
  }

  static Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: false);
      if (result != null && result.xFiles.isNotEmpty) {
        if (result.isSinglePick) {
          return File(result.xFiles.first.path);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
      return null;
    }
  }

  static Future<File?> pickProfileImage(
      {required ImageSource source, String? title, bool showPicker = true}) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 40);
      if (image != null && showPicker) {
        final croppedImage = await ImageCropper()
            .cropImage(sourcePath: image.path, compressQuality: 20, uiSettings: [
          AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: ColorConstantLight.primary,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: title,
            rotateButtonsHidden: true,
            hidesNavigationBar: true,
          ),
        ]);
        if (croppedImage != null) {
          return File(croppedImage.path);
        } else {
          return null;
        }
      } else if (image != null) {
        return File(image.path);
      } else {
        return null;
      }
    } catch (e) {
      DI.i<NavigationService>().showSnackBar(message: 'Something went wrong');
      return null;
    }
  }

  static Future<void> getImageWithFileName(
      {bool showFilePicker = false,
      required String? title,
      required String? subTitle,
      required Function(String, File) onChange}) async {
    DI
        .i<NavigationService>()
        .showBottomsheet(
            title: title,
            subTitle: subTitle,
            child: ImageSourceSelectionBottomSheet(
              titleForCropper: 'Crop Your image',
              pickFile: showFilePicker,
            ))
        .then((value) {
      if (value != null && value is File) {
        final fileName = value.path.split('/').last;
        onChange(fileName, value);
      }
    });
  }

  static Future<File?> imageCompressor(File image) async {
    try {
      // File file = File();
      // final compressImage = await FlutterImageCompress.compressAndGetFile(
      //   image.absolute.path, ,
      //   minHeight: 1920,
      //   minWidth: 1080,
      //   quality: 96,
      //   rotate: 180,
      // );
      return image;
    } catch (e) {
      throw 'compression-failed';
    }
  }

  static Future<List<File>> pickImages(int limit) async {
    List<File> images = [];
    List<XFile> pickedFiles = [];
    try {
      pickedFiles = await ImagePicker().pickMultiImage(limit: limit);
      if (pickedFiles.length > limit) {
        pickedFiles = pickedFiles.sublist(0, limit);
      }
    } on Exception catch (e) {
      DI.i<NavigationService>().showToast(message: e.toString());
    }
    for (final img in pickedFiles) {
      images.add(File(img.path));
    }
    return images;
  }
}
