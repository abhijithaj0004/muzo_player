import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muzoplayer/screens/home/main_screen.dart';
import 'package:muzoplayer/screens/splashscreen/splashScreen.dart';
import 'package:muzoplayer/widgets/ellipse.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController userNameController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to',
                        style: TextStyle(
                            color: Color.fromARGB(255, 87, 84, 84),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KumbhSans'),
                      ),
                      TextSpan(
                          text: ' Muzo',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 47, 33, 243),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KumbhSans')),
                    ],
                  ),
                ),
                Container(
                    child: SvgPicture.asset(
                  'assets/images/undraw_happy_music_g6wc.svg',
                  height: 300,
                )),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'ENTER',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 47, 33, 243),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KumbhSans')),
                      TextSpan(
                        text: ' YOUR NAME',
                        style: TextStyle(
                            color: Color.fromARGB(255, 87, 84, 84),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KumbhSans'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .69,
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        hintText: 'Your Name',
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontFamily: 'KumbhSans'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FaIcon(
                            FontAwesomeIcons.circleUser,
                            size: 40,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'By entering name you will be \n       redirected to the app',
                  style: TextStyle(fontFamily: 'KumbhSans', fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 100, 39, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setBool(loginKey, true);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                      },
                      child: Text(
                        "Let's Go",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'KumbhSans',
                            fontSize: 20),
                      ),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
