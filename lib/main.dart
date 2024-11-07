import 'package:flutter/material.dart';
// ignore: unused_import
import 'views/screens/layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '非凡新聞',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Layout(),
    );
  }
}
