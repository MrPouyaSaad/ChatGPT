import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT',
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: cardColor,
          elevation: 2.0,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: ChatScreen(),
    );
  }
}
