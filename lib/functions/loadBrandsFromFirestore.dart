import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  /// Generic method to fetch a List<String> from Firestore
  static Future<List<String>> getListFromFirestore({
    required String collection,
    required String doc,
    required String field,
  }) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(doc)
              .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data[field] is List) {
          return List<String>.from(data[field]);
        }
      }
      return [collection]; // return empty if nothing found
    } catch (e) {
      print("❌ Firestore fetch failed: $e");
      return [];
    }
  }
}
