import 'package:flutter/material.dart';
import 'package:tell_me_something/theme/colors.dart';
import 'package:tell_me_something/widgets/side_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //side navbar
          SideBar(),
          Column(
            children: [
              //search section
              //footer
            ],
          ),
        ],
      ),
    );
  }
}
