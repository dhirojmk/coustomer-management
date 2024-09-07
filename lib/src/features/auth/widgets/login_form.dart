import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../../core/customer_list_page.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  var obscurePassword = true.obs;
  var rememberMe = false.obs;

  bool validateLogin() {
    return email.value == 'user@maxmobility.in' && password.value == 'Abc@#123';
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
}

class TLoginForm extends StatelessWidget {
  final loginController = Get.put(LoginController());

  TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight),
        child: Column(
          children: [
            /// Email
            TextFormField(
              onChanged: (value) => loginController.email.value = value,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: tEmail,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: tDefaultSize,
            ),

            /// Password
            Obx(() => TextFormField(
              obscureText: loginController.obscurePassword.value,
              onChanged: (value) => loginController.password.value = value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: tPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.obscurePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: () => loginController.togglePasswordVisibility(),
                ),
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            )),
            const SizedBox(height: tDefaultSize / 2),

            /// Remember Me And Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                      value: loginController.rememberMe.value,
                      onChanged: (value) => loginController.rememberMe.value = value ?? false,
                    )),
                    const Text("Remember Me"),
                  ],
                ),

                /// Forgot Password
                TextButton(
                  onPressed: () => Get.toNamed('/forgot-password'),
                  child: const Text(tForgetPassword),
                ),
              ],
            ),
            const SizedBox(height: tDefaultSize / 2),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (loginController.validateLogin()) {
                    Get.to(() => CustomerListPage());
                  } else {
                    Get.snackbar('Error', 'Invalid credentials');
                  }
                },
                icon: const Icon(Iconsax.login_1_copy, color: Colors.white),
                label: const Text(tSignIn, style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 10.0), // Padding
                  textStyle: const TextStyle(fontSize: 16), // Text style
                ),
              ),
            ),
            const SizedBox(
              height: tDefaultSize,
            ),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed('/create-account'),
                icon: const Icon(Iconsax.user_cirlce_add_copy, color: Colors.white),
                label: const Text(createAccount, style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 10.0), // Padding
                  textStyle: const TextStyle(fontSize: 16), // Text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
