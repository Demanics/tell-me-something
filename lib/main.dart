import 'package:flutter/material.dart';
import 'package:tell_me_something/pages/home_page.dart';
import 'package:tell_me_something/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background
      ),
      home: const HomePage(),
    );
  }
}
