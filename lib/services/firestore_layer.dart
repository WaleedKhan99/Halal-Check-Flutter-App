import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_check/services/navigation_services.dart';

import 'di_services.dart';
import 'firebase_db_services.dart';

enum QueryType { get, post, update, delete }

class FirestoreLayer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirestoreLayer(this._firestore);

  Future<ResponseGeneric> makeQuery(
    QueryType type,
    String collection, {
    String? documentId,
    Map<String, dynamic>? data,
  }) async {
    try {
      CollectionReference collectionRef = _firestore.collection(collection);

      switch (type) {
        case QueryType.get:
          QuerySnapshot querySnapshot = await collectionRef.get();
          return ResponseGeneric(
            success: true,
            message: 'successful',
            data: querySnapshot.docs.map((doc) => doc.data()).toList(),
          );
        case QueryType.post:
          await collectionRef.add(data!);
          return ResponseGeneric(
            success: true,
            data: null,
            message: 'successful',
          );
        case QueryType.update:
          await collectionRef.doc(documentId).update(data!);
          return ResponseGeneric(
            success: true,
            data: null,
            message: 'successful',
          );
        case QueryType.delete:
          await collectionRef.doc(documentId).delete();
          return ResponseGeneric(
            success: true,
            data: null,
            message: 'successful',
          );
      }
    } catch (e) {
      DI.i<NavigationService>().showToast(message: e.toString());
      return ResponseGeneric(
        data: null,
        success: false,
        message: e.toString(),
      );
    }
  }
}

// class _CustomExceptionHandler {
//   ResponseGeneric handleException(dynamic e) {
//     return ResponseGeneric(
//       success: false,
//       data: null,
//       message: e.toString(),
//     );
//   }
// }
