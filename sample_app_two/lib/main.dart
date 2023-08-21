import 'package:flutter/material.dart';

import 'modules/views/demo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleView(),
    );
  }
}
