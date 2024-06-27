import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';

class AddCarDetailsFireStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addCarDetails(AddCarDetails carDetails) async {
    try {
      String userId = _auth.currentUser!.uid;
      await _firestore.collection('cars').doc().set({
        ...carDetails.toMap(), // Add all fields from carDetails
        'userId': userId,
      });
      print('Car details added successfully!');
    } catch (e) {
      print('Error adding car details: $e');
    }
  }

  Stream<List<AddCarDetails>> getUserCarsStream() {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('cars')
        .where('userId', isEqualTo: userId) // Filter by user ID
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                AddCarDetails.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<AddCarDetails>> getUserCars() async {
    try {
      String userId = _auth.currentUser!.uid;
      var querySnapshot = await _firestore
          .collection('cars')
          .where('userId', isEqualTo: userId) // Filter by user ID
          .get();

      return querySnapshot.docs
          .map((doc) =>
              AddCarDetails.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching user cars: $e');
      return [];
    }
  }
}
