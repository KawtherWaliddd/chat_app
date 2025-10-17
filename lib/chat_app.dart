import 'package:chat_app/busniess_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/busniess_logic/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/busniess_logic/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginScreen': (context) => LoginScreen(),
          'RegisterScreen': (context) => RegisterScreen(),
          'ChatScreen': (context) => ChatScreen(),
        },
        initialRoute: 'LoginScreen',
      ),
    );
  }
}
