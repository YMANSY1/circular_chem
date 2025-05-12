import 'package:get/get.dart';

class AuthController extends GetxController {
  // For toggling between login and signup screens
  final isLogin = true.obs;

  // For password visibility
  final isObscured = true.obs;

  // For loading state
  final isLoading = false.obs;

  void toggleMode() {
    isLogin.value = !isLogin.value;
  }

  void toggleObscured() {
    isObscured.value = !isObscured.value;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
