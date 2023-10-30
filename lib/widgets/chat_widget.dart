// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_gpt/constants/const.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.isUser,
    required this.msg,
  }) : super(key: key);
  final bool isUser;
  final String msg;

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
                    msg,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                if (!isUser) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.thumb_down_alt_outlined,
                        color: Colors.white,
                      )
                    ],
                  )
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}
