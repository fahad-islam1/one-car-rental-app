import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';
import 'package:one_car_rental_app/res/utils/snackbarmsg.dart';

class AddCarDetailsFireStore {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addCarDetails(AddCarDetails carDetails) async {
    try {
      String userId = auth.currentUser!.uid;
      await firestore.collection('cars').doc().set({
        ...carDetails.toMap(),
        'userId': userId,
      });
      print('Car details added successfully!');
    } catch (e) {
      print('Error adding car details: $e');
    }
  }

  Stream<List<AddCarDetails>> getUserCarsStream() {
    String userId = auth.currentUser!.uid;
    return firestore
        .collection('cars')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AddCarDetails.fromMap(doc.data(), id: doc.id))
            .toList());
  }

  Future<List<AddCarDetails>> getUserCars() async {
    try {
      String userId = auth.currentUser!.uid;
      var querySnapshot = await firestore
          .collection('cars')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => AddCarDetails.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      print('Error fetching user cars: $e');
      return [];
    }
  }

  Future<void> deleteCar(String carId) async {
    try {
      await firestore.collection('cars').doc(carId).delete();
      Message.showSuccess('', 'Car deleted successfully!');
      print('Car deleted successfully!');
    } catch (e) {
      Message.showError('Error deleting car', '$e');
      print('Error deleting car: $e');
    }
  }
}
