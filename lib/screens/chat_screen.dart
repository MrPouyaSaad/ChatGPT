import 'package:chat_gpt/constants/const.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
    );
  }
}

AppBar myAppBar() {
  return AppBar(
    title: Text('SaadGPT'),
    leading: Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Image.asset(openAiLogo),
    ),
  );
}
