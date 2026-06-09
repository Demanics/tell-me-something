import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tell_me_something/services/chat_web_service.dart';
import 'package:tell_me_something/theme/colors.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading=true;
  List searchResults = [
    {
      "title": "The Man - Muhammad Ali: A Transcendent Life - UofL Libraries at University of Louisville",
      "url": "https://library.louisville.edu/ali/theman",
      "content": "Skip to Main Content\nUniversity of Louisville\nAsk Us\nMeet with a librarian\nEmail a reference question\nCall Us\nArchives & Special Collections\n502.852.6752\nArt Library\n502.852.6741\nEkstrom Library\n502.852.0433\nKornhauser Health Sciences Library\n502.852.5771\nLaw Library\n502.852.0729\nMusic Library\n502.852.5659\nChat service is available Monday-Friday between 9am and 5pm.\nLibraries\nArchives & Special Collections\nhome\nBridwell Art Library\nhome\nEkstrom Library\nhome\nKornhauser Health Sciences Library\nhome\nLaw Library\nhome\nMusic Library\nhome\nUniversity Hospital Library\nhome\nAccounts\nRenew Books\nInterlibrary Loan\nvia Ekstrom Library\nMake a Payment\nOff-Campus Login\nBlackboard\nCardinal Card\nEmail\nMy Print Center\nULink\nUniversity Libraries\nSite search\nSearch U of L Libraries site\nsearch\nUniversity of Louisville\nUofL Libraries\nUniversity Libraries\nMuhammad Ali: A Transcendent Life\nThe Man\nMuhammad Ali: A Transcendent Life\n: The Man\nA collaborative project between the UofL Muhammad Ali Institute and the University Libraries.\nHome\nThe Man\nBoxing Excellence\nAli and Islam\nHumanitarian and Peace Advocate\nSocial Justice and Civil Rights Icon\nThe Artist\nPublic Art and Monuments\nTimeline\n<<\nPrevious:\nHome\nNext:\nBoxing Excellence >>\nTop\nBottom",
      "relevance_score": 0.47194939851760864
    },
    {
      "title": "Muhammad Ali | U.S. Olympic & Paralympic Hall of Fame",
      "url": "https://usopm.org/muhammad-ali",
      "content": "Cassius Clay arrived at the Rome 1960 Olympic Games as a relatively unknown 18-year-old. He had a terrific amateur resume and was considered the United States’ best hope to win a gold medal in boxing, but there was little to suggest that his four victories would launch a career of a world champion boxer as well as a world-class activist and philanthropist.\nAt one point in the months leading to the Games, it appeared Clay might not even make it to Europe. Even after being convinced to fly from Louisville to San Francisco for the U.S. Olympic Trials, Clay still hated flying and told his longtime trainer that he would rather skip the trip than get on a plane for another long flight.\nEventually, though, Clay was persuaded – but first he purchased a parachute and and strapped it to his back for the flight.\nClay breezed through the Olympic competition, with three unanimous decisions and one knockout, including victories over two 1956 medal winners. Gregarious inside the ring and out, Clay also was a hit in the Olympic Village, shaking hands and exchanging pins.\nClay turned professional after the Olympics and in 1964 beat Sonny Liston to become heavyweight champion. Soon after, Clay changed his name to Cassius X and then he converted to Islam, changing his name to Muhammad Ali. In 1966, he refused to serve in the U.S. military because of his objection to the Vietnam War, beginning a crusade in which he brought attention to various causes but preventing him from boxing for the next three years as various sanctioning bodies denied him a license. In 1971, the U.S. Supreme Court overturned Ali’s conviction of violating the Selective Service.\nAli continued his boxing career with several high-profile bouts, reclaiming the world heavyweight championship. He also traveled the world to promote peace and help those who needed it. And he remained involved in the Olympic movement. At the Atlanta 1996 Olympic Games, Ali was the final torch bearer and lit the Olympic Flame. At the London 2012 Olympic Games, Ali was among a group that escorted the Olympic Flag into the stadium for the Opening Ceremony.\nAli passed away on June 3, 2016, after battling Parkinson’s Disease. He was 74.",
      "relevance_score": 0.31684842705726624
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatWebService().searchResultStream.listen((data) {
      setState(() {
        searchResults=data['data'];
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.source_outlined, color: AppColors.iconGrey),
              const SizedBox(width: 8),
              Text(
                'Sources',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Skeletonizer(
            effect: const ShimmerEffect(
              baseColor: AppColors.cardColor,
              highlightColor: AppColors.textGrey,
              duration: Duration(seconds: 1)
            ),
            enabled: isLoading,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: searchResults.map((res) {
                return Container(
                  width: 150,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        res['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.whiteColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        res['url'],
                        style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
