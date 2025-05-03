import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatBubbleYourFriend extends StatelessWidget {
  const ChatBubbleYourFriend({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Text(
          messageModel.message,
          style: AppTextStyles.pacificoRegular.copyWith(fontSize: 19),
        ),
      ),
    );
  }
}
