import 'package:flutter/material.dart';
import '../../constant.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isMe});

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe == true ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.fromLTRB(space, space, space, 0),
        padding: const EdgeInsets.symmetric(horizontal: space, vertical: space),
        constraints: const BoxConstraints(
          minWidth: 60,
        ),
        decoration: BoxDecoration(
          color: isMe == true ? pColor : Colors.indigoAccent,
          borderRadius: isMe == true
              ? const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
