import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 73, 13, 169),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                )),
            const Text(
              "MUZO is the ultimate music player for those  who love to groove to the rhythm of their favorite tunes .If you are looking for a music player that can handle any genre, any mood, and any occasion, look no further than MUZO .MUZO is more than a music player. it's your musical companion. Get yours now and feel the beast",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'KumbhSans',
                  fontSize: 14),
            ),
          ],
        ),
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Created by :-Abhijith AJ',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'KumbhSans',
                  fontSize: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Contact Developer :-',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: 'KumbhSans',
                        fontSize: 13),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://www.linkedin.com/in/abhijith-aj-7a28a2254/');
                      await launchUrl(url,
                          mode: LaunchMode.externalNonBrowserApplication);
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () async {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'ar.creationsq@gmail.com',
                        query: encodeQueryParameters(<String, String>{
                          'subject': 'Muzo related query',
                        }));
                    await launchUrl(emailLaunchUri);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.envelope,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
