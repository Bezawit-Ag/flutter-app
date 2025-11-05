import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World App'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Hello, Beza! 👋',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
