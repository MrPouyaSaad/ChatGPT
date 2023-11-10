// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/providers/models_provider.dart';
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
  late ScrollController _scrollController;
  late FocusNode _focusNode;
  bool isError = false;
  @override
  void initState() {
    _scrollController = ScrollController();
    _msgController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _msgController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    final chatList = chatProvider.getchatList;
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
              controller: _scrollController,
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
            focusNode: _focusNode,
            isEnable: !_isTyping,
            isError: isError,
            onSubmitted: (value) async {
              if (_msgController.text.isNotEmpty) {
                _focusNode.unfocus();
                await sendMessage(
                    modelsProvider: modelProvider, chatProvider: chatProvider);
              } else {
                setState(() {
                  isError = true;
                });
              }
            },
            sendMsgFunction: () async {
              if (_msgController.text.isNotEmpty) {
                _focusNode.unfocus();
                await sendMessage(
                    modelsProvider: modelProvider, chatProvider: chatProvider);
              } else {
                setState(() {
                  isError = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void scrollListToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  Future<void> sendMessage(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    String tempMsg = _msgController.text;
    try {
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: _msgController.text);
        _msgController.clear();
      });

      await chatProvider.getAnswers(
        msg: tempMsg,
        modelID: modelsProvider.getCurrentlyModel,
      );
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({
    Key? key,
    required this.isEnable,
    required this.msgController,
    required this.sendMsgFunction,
    required this.onSubmitted,
    required this.focusNode,
    required this.isError,
  }) : super(key: key);
  final bool isEnable;
  final TextEditingController msgController;
  final Function() sendMsgFunction;
  final Function(String value) onSubmitted;
  final FocusNode focusNode;
  final bool isError;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, bottom: 4, top: 4),
      decoration: BoxDecoration(
        color: cardColor,
        border: isError
            ? Border.all(color: Theme.of(context).colorScheme.error, width: 2)
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: isEnable,
              focusNode: focusNode,
              controller: msgController,
              onSubmitted: onSubmitted,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  displayFullTextOnTap: true,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      'How can I help you?'.trim(),
                      speed: Duration(milliseconds: 50),
                      textStyle: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
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
