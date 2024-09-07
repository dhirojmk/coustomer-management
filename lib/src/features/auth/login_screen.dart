import 'package:coustomer_management/src/features/auth/widgets/login_divider_social/form_divider.dart';
import 'package:coustomer_management/src/features/auth/widgets/login_divider_social/social_buttons.dart';
import 'package:coustomer_management/src/features/auth/widgets/login_form.dart';
import 'package:coustomer_management/src/features/auth/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              ///logo,title and subtitle
              const TLoginHeader(),

              ///Form
              TLoginForm(),

              ///Devider
              const TFormDivider(dividerText: 'Or SignInWith'),

              const SizedBox(
                height: tDefaultSize,
              ),

              ///Footer
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
