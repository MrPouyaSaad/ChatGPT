// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_gpt/constants/const.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.isUser,
  }) : super(key: key);
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: isUser ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  isUser ? personImage : chatLogo,
                  width: 36,
                  height: 36,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    'Hello',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
