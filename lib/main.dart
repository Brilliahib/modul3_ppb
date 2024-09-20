import 'package:flutter/material.dart';
import 'package:mod3_kel26/screen/splash_screen.dart';
import './widget/navigation.dart';

void main() {
  runApp(const MangaApp());
}

class MangaApp extends StatelessWidget {
  const MangaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MangaApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 3, 116, 255),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
