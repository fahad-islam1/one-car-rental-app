import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      await db.collection('users').doc(phoneNumber).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': '',
        'imageUrl': ''
      });
      print('User added to Firestore');
    } catch (e) {
      print('Error adding user to Firestore: $e');
      throw Exception('Failed to add user');
    }
  }

  Future<bool> isPhoneNumberRegistered(String phoneNumber) async {
    try {
      DocumentSnapshot docSnapshot =
          await db.collection('users').doc(phoneNumber).get();
      return docSnapshot.exists;
    } catch (e) {
      print('Error checking phone number registration: $e');
      throw Exception('Failed to check phone number registration');
    }
  }

  Stream<Map<String, dynamic>?> getUserDataStream(String phoneNumber) {
    try {
      return db.collection('users').doc(phoneNumber).snapshots()
          .map((docSnapshot) => docSnapshot.exists ? docSnapshot.data() as Map<String, dynamic> : null);
    } catch (e) {
      print('Error fetching user data stream: $e');
      throw Exception('Failed to fetch user data stream');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String phoneNumber) async {
    try {
      DocumentSnapshot docSnapshot =
          await db.collection('users').doc(phoneNumber).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      throw Exception('Failed to fetch user data');
    }
  }

  Future<void> updateUser({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String imageUrl,
  }) async {
    try {
      await db.collection('users').doc(phoneNumber).update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'imageUrl': imageUrl,
      });
      print('User data updated in Firestore');
    } catch (e) {
      print('Error updating user in Firestore: $e');
      throw Exception('Failed to update user');
    }
  }
}
