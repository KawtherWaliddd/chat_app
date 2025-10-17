import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener, BlocProvider;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/busniess_logic/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/busniess_logic/cubit/login_cubit/login_cubit_state.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/register_widget.dart';
import 'package:chat_app/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> keyState = GlobalKey<FormState>();
  bool isLoading = false;

  LoginScreen({super.key});

  void dispose() {
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          Navigator.pushNamed(context, 'ChatScreen');
        } else if (state is LoginFailureState) {
          showsnackBar(context, 'something went wrong');
        }
      },
      child: ModalProgressHUD(
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
                          BlocProvider.of<LoginCubit>(
                            context,
                          ).login(email: email.text, password: password.text);
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
      ),
    );
  }
}
