import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Log In.',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomField(
              hint: 'Email',
              controller: emailController,
            ),
            SizedBox(
              height: 15,
            ),
            CustomField(
              hint: 'Password',
              controller: passwordController,
              isObscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            AuthGradientButton(
              buttonText: 'LogIn',
              onPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                  TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                          color: Pallete.gradient3,
                          fontWeight: FontWeight.bold))
                ]))
          ]),
        ),
      ),
    );
  }
}
