import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref.watch(authViewModalProvider)?.isLoading == true;
    ref.listen(authViewModalProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(context, 'Account created successfully! please login');

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(authViewModalProvider.notifier)
                                .siggnUpUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext) {
                            return const LoginPage();
                          }));
                        },
                        child: RichText(
                            text: TextSpan(
                                text: 'Already have and account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                      color: Pallete.gradient3,
                                      fontWeight: FontWeight.bold))
                            ])),
                      )
                    ]),
              ),
            ),
    );
  }
}
