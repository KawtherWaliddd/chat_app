import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/register_widget.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> keyState = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: ColorsManager.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: keyState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Text('Scholar Chat', style: AppTextStyles.pacificoRegular),
                  const SizedBox(height: 32),
                  TextFieldButton(
                    hintText: 'Email',
                    controllerText: email,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  TextFieldButton(
                    hintText: 'Password',
                    controllerText: password,
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  ButtonWidget(
                    onPressed: () async {
                      if (keyState.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          // Sign in using Firebase Authentication
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                          // After successful login, pass the email to ChatScreen
                          Navigator.pushReplacementNamed(
                            context,
                            'ChatScreen',
                            arguments: email.text,
                            // Pass the email to the ChatScreen
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showsnackBar(
                              context,
                              'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showsnackBar(context, 'Wrong password provided.');
                          } else {
                            showsnackBar(
                              context,
                              'Error: ${e.message}. Please try again later.',
                            );
                          }
                        } catch (e) {
                          showsnackBar(
                            context,
                            'An unexpected error occurred. Please try again later.',
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                  RegisterWidget(
                    text: 'Sign Up',
                    registerType: "Don't have an account?",
                    onPressed: () {
                      Navigator.pushNamed(context, "RegisterScreen");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
