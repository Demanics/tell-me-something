import 'package:flutter/material.dart';
import 'package:tell_me_something/theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello World',style: TextStyle(color: AppColors.textGrey),),
      ),
    );
  }
}