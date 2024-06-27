import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_car_rental_app/data/services/firebase/firestore_service.dart';
import 'package:one_car_rental_app/data/services/firebase/firestorage_service.dart';
import 'package:one_car_rental_app/data/services/sharedpreference/shared_pref_service.dart';
import 'package:one_car_rental_app/presentation/views/auth/login_screen.dart';

class ProfileViewModel extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  final FirestorageService firestorageService = FirestorageService();
var phonenumber='';
  var userData = {}.obs;
  var isLoading = false.obs;
  var gender = ''.obs;
  var imageUrl = ''.obs;

  void fetchUserData(String phoneNumber) {
    isLoading.value = true;
    try {
      firestoreService.getUserDataStream(phoneNumber).listen((data) {
        if (data != null) {
          userData.value = data;
          gender.value = data['gender'] ?? '';
          imageUrl.value = data['imageUrl'] ?? '';
        } else {
          userData.clear();
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(String firstName, String lastName, String email, String phoneNumber) async {
    isLoading.value = true;
    try {
      await firestoreService.updateUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender.value,
        imageUrl: imageUrl.value,
      );
    } catch (e) {
      print('Error updating user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(String phoneNumber) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isLoading.value = true;
      try {
        String downloadUrl = await firestorageService.uploadImage(image, phoneNumber);
        imageUrl.value = downloadUrl;
      } catch (e) {
        print('Error uploading image: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> logout() async {
    try {
      await SharedPrefService.clearLoggedIn();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}