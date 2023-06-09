import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzoplayer/screens/welcomescreens/login.dart';
import 'package:muzoplayer/widgets/ellipse.dart';

class IntroTwo extends StatelessWidget {
  const IntroTwo({super.key});

  @override
  Widget build(BuildContext context) {
    String music = 'Music can change the world because \nit can change people';
    return Scaffold(
      body: Column(
        children: [
          Container(
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
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/images/undraw_compose_music_re_wpiw.svg',
                    height: 400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 47, 33, 243),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KumbhSans'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          music,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 96, 96, 98),
                              fontFamily: 'KumbhSans'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 103, 61, 255),
                      borderRadius: BorderRadius.circular(50)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'KumbhSans',
                            fontSize: 20),
                      )),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
