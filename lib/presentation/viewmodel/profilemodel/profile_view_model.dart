import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_car_rental_app/data/services/firebase/firestore_service.dart';
import 'package:one_car_rental_app/data/services/firebase/firestorage_service.dart';
import 'package:one_car_rental_app/data/services/sharedpreference/shared_pref_service.dart';
import 'package:one_car_rental_app/presentation/views/auth/login_screen.dart';
import 'package:one_car_rental_app/res/utils/snackbarmsg.dart';

class ProfileViewModel extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  final FirestorageService firestorageService = FirestorageService();

  var phonenumber = '';
  var userData = {}.obs;
  var isLoading = false.obs;
  var gender = ''.obs;
  var imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      isLoading.value = true;
      phonenumber = await SharedPrefService.getPhoneNumber() ?? '';
      if (phonenumber.isNotEmpty) {
        final data = await firestoreService.getUserData(phonenumber);
        if (data != null) {
          userData.value = data;
          gender.value = data['gender'] ?? '';
          imageUrl.value = data['imageUrl'] ?? '';
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(String firstName, String lastName, String email,
      String phonenumber) async {
    isLoading.value = true;
    try {
      await firestoreService.updateUser(
        phoneNumber: phonenumber,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender.value,
        imageUrl: imageUrl.value,
      );
      userData.value = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phonenumber,
        'gender': gender.value,
        'imageUrl': imageUrl.value,
      };
      Get.back();
    } catch (e) {
      Message.showSuccess('Error updating user', '$e');
      print('Error updating user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(phonenumber) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      isLoading.value = true;
      try {
        String downloadUrl =
            await firestorageService.uploadImage(image, phonenumber);
        imageUrl.value = downloadUrl;
        userData['imageUrl'] = downloadUrl;
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
