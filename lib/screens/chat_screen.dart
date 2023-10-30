// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/providers/models_provider.dart';
import 'package:chat_gpt/services/api.dart';
import 'package:chat_gpt/services/services.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController _msgController;
  @override
  void initState() {
    _msgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(
      context,
    );

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
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  isUser: index.isEven,
                  msg: chatList[index].msg,
                );
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black26,
          ),
          MyBottomNavigation(
            msgController: _msgController,
            onSubmitted: (value) async {
              await sendMessage(modelsProvider: modelProvider);
            },
            sendMsgFunction: () async {
              await sendMessage(modelsProvider: modelProvider);
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: _msgController.text, index: 0));
        _msgController.clear();
      });
      log('Message Sent');
      chatList.addAll(
        await ApiServices.sendMsg(
          msg: _msgController.text,
          model: modelsProvider.getCurrentlyModel,
        ),
      );
      setState(() {});
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }
}

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({
    Key? key,
    required this.msgController,
    required this.sendMsgFunction,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController msgController;
  final Function() sendMsgFunction;
  final Function(String value) onSubmitted;
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
                controller: msgController,
                onSubmitted: onSubmitted,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration.collapsed(
                  hintText: 'How can I help you?',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: sendMsgFunction,
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
