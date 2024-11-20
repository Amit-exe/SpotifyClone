import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
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
              'Sign Up.',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomField(
              hint: 'Name',
              controller: nameController,
            ),
            SizedBox(
              height: 15,
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
              buttonText: 'SignUp',
              onPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    text: 'Already have and account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                  TextSpan(
                      text: 'Sign In',
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
