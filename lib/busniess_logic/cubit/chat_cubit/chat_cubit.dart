import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  final TextEditingController messageController = TextEditingController();
  final ScrollController listController = ScrollController();

  void sendMessage({required String message, required String email}) {
    messages
        .add({'message': message, 'id': email, 'timestamp': DateTime.now()})
        .then((_) {
          messageController.clear();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (listController.hasClients) {
              listController.jumpTo(listController.position.maxScrollExtent);
            }
          });
        });
  }

  Stream<QuerySnapshot> getMessages() {
    return messages.orderBy('timestamp', descending: false).snapshots();
  }
}
