import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isLoading = ref.watch(authViewModalProvider)?.isLoading == true;
    ref.listen(authViewModalProvider, (_, next) {
      next?.when(
          data: (data) {
            // TODO: navigate to home
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => LoginPage(),
            //   ),
            // );
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        onPressed: () async {
                          final res = await AuthRemoteRepository().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          final val = switch (res) {
                            Left(value: final l) => l,
                            Right(value: final r) => r,
                          };
                          print(val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext) {
                            return const SignupPage();
                          }));
                        },
                        child: RichText(
                            text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                              TextSpan(
                                  text: 'Sign Up',
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
