import 'package:chat_app/busniess_logic/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/busniess_logic/cubit/register_cubit/register_state.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/register_widget.dart';
import 'package:chat_app/widgets/text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController userName = TextEditingController();

  final GlobalKey<FormState> keyState = GlobalKey();

  RegisterScreen({super.key});
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, 'ChatScreen');
        } else if (state is RegisterFailureState) {
          showsnackBar(context, 'something went wrong');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: ColorsManager.primaryColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: keyState,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/scholar.png'),
                        Text(
                          'Scholar Chat',
                          style: AppTextStyles.pacificoRegular,
                        ),
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
                              BlocProvider.of<RegisterCubit>(context).register(
                                email: email.text,
                                password: password.text,
                              );
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
          ),
        );
      },
    );
  }
}
