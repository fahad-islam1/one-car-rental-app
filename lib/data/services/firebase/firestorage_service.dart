import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FirestorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(XFile image, String userId) async {
    try {
      String fileName = 'profile_images/$userId.jpg';
      Reference reference = _storage.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(File(image.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }

  Future<String> uploadCarImage(File imageFile) async {
    try {
      // Create a unique filename based on timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload file to Firebase Storage
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('car_images/$fileName')
          .putFile(imageFile);

      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw Exception('Failed to upload image.');
    }
  }
}
