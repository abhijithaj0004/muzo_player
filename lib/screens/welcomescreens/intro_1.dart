import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzoplayer/screens/welcomescreens/intro_2.dart';
import 'package:muzoplayer/widgets/ellipse.dart';

class IntroOne extends StatelessWidget {
  const IntroOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                  top: -100,
                  child: Ellipse(color: Color.fromARGB(54, 89, 52, 255))),
              Positioned(
                  left: -100,
                  child: Ellipse(color: Color.fromRGBO(158, 158, 158, 0.249)))
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/images/undraw_music_re_a2jk.svg',
                    height: 400,
                  ),
                ),
                Container(
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Music',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 47, 33, 243),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KumbhSans')),
                    TextSpan(
                        text: ' is an Outburst of \n               the Soul',
                        style: TextStyle(
                            color: Color.fromARGB(255, 87, 84, 84),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KumbhSans'))
                  ])),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'THIS APP ALLOWS YOU TO PLAY \nAND ORGANIZE MUSIC EASILY',
                  style: TextStyle(
                      fontFamily: 'KumbhSans',
                      color: Color.fromARGB(255, 123, 118, 118)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 150),
                  width: MediaQuery.of(context).size.width * .25,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 103, 61, 255),
                      borderRadius: BorderRadius.circular(50)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const IntroTwo()));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'KumbhSans',
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
