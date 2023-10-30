import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/controllers/profile_controller.dart';
import 'package:test_app/utils/controllers/theme_controller.dart';
import 'package:test_app/utils/services/error_handling.dart';
import 'package:test_app/utils/view/home_page.dart';
import 'package:test_app/utils/view/login_page.dart';
import 'package:test_app/utils/widgets/bottomSheet/bottom_sheet_custom.dart';

class AuthController extends GetxController {
  ProfileController controller = Get.put(ProfileController());
  ThemeController themecontroller = Get.put(ThemeController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isPasswordVisible2 = false.obs;
  var isLoading = false.obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> createUser(
      String email, String password, String fullName) async {
    try {
      isLoading(true);
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'fullName': fullName,
        'email': email,
        'password':
            password, // Storing password in plaintext (for demonstration purposes only)
        'profilePicUrl': '',
        'phone': '',
        'gender': '' // Initialize with an empty profile picture URL
      });
      controller.fetchUserInfo();
      Get.off(() => MyHomePage());
    } catch (e) {
      showFirebaseSignUpSnackbar(e);
    } finally {
      isLoading(false); // Set loading to false when authentication process ends
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      controller.fetchUserInfo();
      Get.off(() => MyHomePage());
    } catch (e) {
      showFirebaseAuthSnackbar(e);
    } finally {
      isLoading(false); // Set loading to false when authentication process ends
    }
  }

  Future<void> signOut() async {
    try {
      isLoading(true);
      await _auth.signOut();
      Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      isLoading(true);
      User user = FirebaseAuth.instance.currentUser!;
      await user.delete();
      // Account deleted successfully
    } catch (e) {
      // Handle error, for example, show a snackbar with the error message
    } finally {
      isLoading(false); // Set loading to false when authentication process ends
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      isLoading(true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      Get.bottomSheet(BottomSheetCustomCode(
        controller: themecontroller,
      ));

      // You can show a success message or navigate to a different screen here
    } catch (e) {
      showFirebasePasswordResetSnackbar(e);
    } finally {
      isLoading(false); // Set loading to false when authentication process ends
    }
  }
}
