import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/chat_page.dart';
import 'providers/chat_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatIO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.green.shade600,
          secondary: Colors.green.shade900,
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ChatProvider(),
        child: ChatPage(),
      ),
    );
  }
}