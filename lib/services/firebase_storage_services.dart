import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../shared/helper/helper_function.dart';

class FirebaseStorageDBService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadMultipleImages(
      {required List<File> imageFiles,
      required List<String> prevUrls,
      required List<String> path}) async {
    List<String> imageUrls = [];
    try {
      if (imageFiles.isNotEmpty) {
        final Reference storageref = _createReference(path);
        final uploadResponse = await Future.wait(
            List<Future<String>>.generate(imageFiles.length, (index) {
          return _createUploadImageJob(storageref, imageFiles[index]);
        }));
        imageUrls.addAll(uploadResponse);
      }

      //deleting previous uploaded images
      if (prevUrls.isNotEmpty) {
        for (int i = 0; i < prevUrls.length; i++) {
          _removePrevPhoto(prevUrls[i]);
        }
      }

      return imageUrls;
    } catch (e) {
      return prevUrls;
    }
  }

  Future<String?> uploadImage(
      {File? imgFile, String? prevUrl, required List<String> path}) async {
    try {
      if (imgFile != null) {
        final Reference storageref = _createReference(path);
        final downloadUrl = await _createUploadImageJob(storageref, imgFile);
        if (prevUrl != null) _removePrevPhoto(prevUrl);
        return downloadUrl;
      } else {
        return prevUrl;
      }
    } catch (e) {
      return prevUrl;
    }
  }

  Future<String> _createUploadImageJob(Reference reference, File file) async {
    final compressedImage = await HelperFunction.imageCompressor(file);
    UploadTask uploadTask = reference
        .child(compressedImage!.path.split('/').last)
        .putFile(compressedImage);
    return await uploadTask.then((snap) async {
      final String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    }).catchError((e) {
      throw e;
    });
  }

  Future<bool> _removePrevPhoto(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Reference _createReference(List<String> path) {
    Reference storageRef = _storage.ref();
    for (String ref in path) {
      storageRef = storageRef.child(ref);
    }
    return storageRef;
  }
}
