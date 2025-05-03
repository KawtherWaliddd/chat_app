import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/register_widget.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController userName = TextEditingController();

  final GlobalKey<FormState> keyState = GlobalKey();

  bool isLoading = false;

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Text('Scholar Chat', style: AppTextStyles.pacificoRegular),
                  const SizedBox(height: 32),
                  TextFieldButton(
                    hintText: 'Username',
                    controllerText: userName,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),

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
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                          isLoading = true;
                          setState(() {});

                          Navigator.popAndPushNamed(
                            context,
                            'ChatScreen',
                            arguments: email,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showsnackBar(
                              context,
                              'The password provided is too weak.',
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showsnackBar(
                              context,
                              'The account already exists for that email.',
                            );
                          }
                        } catch (e) {
                          showsnackBar(context, e.toString());
                          isLoading = false;
                        }
                      }
                    },
                  ),
                  RegisterWidget(
                    text: 'Login',
                    registerType: 'Already have account?',
                    onPressed: () {
                      Navigator.pop(context);
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
