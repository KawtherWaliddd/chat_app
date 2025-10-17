import 'package:chat_app/busniess_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/chat_bubble_list.dart';
import 'package:chat_app/widgets/input_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.email!;
    final chatCubit = context.read<ChatCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(width: 70, height: 70, 'assets/images/scholar.png'),
            Text('Chat', style: AppTextStyles.pacificoRegular),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatCubit.getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                }

                final List<MessageModel> messageList =
                    snapshot.data!.docs
                        .map(
                          (doc) => MessageModel.fromJson(
                            doc.data() as Map<String, dynamic>,
                          ),
                        )
                        .toList();

                return ChatBubbleList(
                  messageList: messageList,
                  controller: chatCubit.listController,
                );
              },
            ),
          ),
          InputMessage(
            onSubmitted: (String message) {
              chatCubit.sendMessage(message: message, email: id);
            },
            messageController: chatCubit.messageController,
          ),
        ],
      ),
    );
  }
}
