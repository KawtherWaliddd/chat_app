import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:chat_app/widgets/chat_bubble_list.dart';
import 'package:chat_app/widgets/input_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController messageController = TextEditingController();
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  final ScrollController listController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.email!;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('timestamp', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<MessageModel> messageList =
              snapshot.data!.docs.map((doc) {
                return MessageModel.fromJson(doc.data());
              }).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsManager.primaryColor,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    width: 70,
                    height: 70,
                    'assets/images/scholar.png',
                  ),
                  Text('Chat', style: AppTextStyles.pacificoRegular),
                ],
              ),
            ),
            body: Column(
              children: [
                ChatBubbleList(
                  messageList: messageList,
                  controller: listController,
                ),
                InputMessage(
                  onSubmitted: (String message) {
                    messages.add({
                      'message': message,
                      'id': id,
                      'timestamp': DateTime.now(),
                    });
                    messageController.clear();
                    listController.jumpTo(
                      listController.position.maxScrollExtent,
                    );
                  },
                  messageController: messageController,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Has Error"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
