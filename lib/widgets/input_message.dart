import 'package:flutter/material.dart';

class InputMessage extends StatelessWidget {
  const InputMessage({
    super.key,
    required this.onSubmitted,
    required this.messageController,
  });

  final Function(String message) onSubmitted;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: "Send message",
        suffixIcon: IconButton(
          icon: const Icon(Icons.send, color: Colors.grey, size: 25),
          onPressed: () => onSubmitted(messageController.text),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
