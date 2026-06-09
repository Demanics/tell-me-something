import 'package:flutter/material.dart';
import 'package:tell_me_something/widgets/chat_sections/answer_section.dart';
import 'package:tell_me_something/widgets/side_bar/side_bar.dart';
import 'package:tell_me_something/widgets/chat_sections/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(),
          const SizedBox(width: 100),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1000),
                      child: Text(
                        question,
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SourcesSection(),
                    const SizedBox(height: 24),
                    AnswerSection()
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
    );
  }
}
