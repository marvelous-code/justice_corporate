import 'dart:convert'; // for base64 encoding
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Uploads an image as base64 string into Firestore along with metadata.
/// Works the same on Web and Android/iOS.
Future<void> uploadImageWithData(
  String collectionName,
  Map<String, dynamic> data,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    print("❌ No file selected.");
    return;
  }

  try {
    Uint8List bytes;

    if (kIsWeb) {
      // 🔹 Web: directly read as bytes
      bytes = await pickedFile.readAsBytes();
    } else {
      // 🔹 Android/iOS: read from File as bytes
      File file = File(pickedFile.path);
      bytes = await file.readAsBytes();
    }

    // Convert to base64
    String base64Image = base64Encode(bytes);

    // Add to Firestore with metadata
    data.addAll({
      "imageBase64": base64Image,
      "uploadedAt": FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection(collectionName).add(data);
    print("✅ Uploaded to Firestore (base64 for all platforms)");
  } catch (e) {
    print("❌ Upload failed: $e");
    rethrow;
  }
}
