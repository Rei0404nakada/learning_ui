import 'package:flutter/material.dart';
import 'package:learning_ui/bottom_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomTabBar(),
    );
  }
}
