import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tell_me_something/services/chat_web_service.dart';
import 'package:tell_me_something/theme/colors.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullresponse = """
# General Rani

"General Rani" was the nickname of **Akleem Akhtar**, a Pakistani socialite associated with **Yahya Khan** during his rule over Pakistan from **1969–1971**.

She did **not** hold any official military or government position. However, she was widely believed to have significant social and political influence because of her close relationship with Yahya Khan.

The title **"General Rani"** was not an actual military rank:

- **Rani** means *queen*.
- **General** was informally attached by the public and media because of her perceived influence within military and political circles.

She remains a controversial historical figure, as opinions about her role vary and are often mixed with political narratives and historical debate.
""";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatWebService().contentStream.listen((data) {
      setState(() {
        if (isLoading == true) {
          fullresponse = "";
        }
        fullresponse += data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell Me Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Skeletonizer(
            effect: const ShimmerEffect(
              baseColor: AppColors.cardColor,
              highlightColor: AppColors.textGrey,
              duration: Duration(seconds: 1),
            ),
            enabled: isLoading,
            child: Markdown(
              data: fullresponse,
              shrinkWrap: true,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                  .copyWith(
                    codeblockDecoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    code: const TextStyle(fontSize: 16),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
