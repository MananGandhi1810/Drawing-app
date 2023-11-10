import 'package:flutter/material.dart';

import 'presentation/drawing_page.dart';

void main() async {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const DrawingPage(),
    );
  }
}
