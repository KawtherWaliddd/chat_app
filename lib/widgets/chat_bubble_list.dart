import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_bubble_your_friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBubbleList extends StatelessWidget {
  const ChatBubbleList({
    super.key,
    required this.messageList,
    required this.controller,
  });
  final List<MessageModel> messageList;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.email!;
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final message = messageList[index];
          final isMe = message.id == currentUserId;

          return isMe
              ? ChatBubbleYourFriend(messageModel: message)
              : ChatBubble(messageModel: message);
        },
      ),
    );
  }
}
