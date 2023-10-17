import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/services/services.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isTyping
          ? SizedBox(
              height: 120,
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              ),
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ChatWidget(
                  isUser: index.isEven,
                );
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black26,
          ),
          MyBottomNavigation(),
        ],
      ),
    );
  }
}

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 4, top: 4),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration.collapsed(
                  hintText: 'How can I help you?',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar myAppBar(BuildContext context) {
  return AppBar(
    title: Text('SaadGPT'),
    leading: Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Image.asset(openAiLogo),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          await Services.showBottomSheet(context);
        },
        icon: Icon(Icons.more_vert_rounded),
      ),
    ],
  );
}
