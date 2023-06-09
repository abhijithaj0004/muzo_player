import 'package:flutter/material.dart';
import 'package:muzoplayer/screens/home/main_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        settings(
          title: 'Share Muzo',
          icon: Icons.share,
          toNextPage: () {
            Share.share('Check out this awesome app! https://example.com');
          },
        ),
        SizedBox(
          height: 7,
        ),
        ListTile(
          onTap: () async {
            // final url = 'https://abhijithaj0004.github.io';
            // if (await canLaunchUrl()) {
            await launchUrl(
                Uri.https('abhijithaj0004.github.io', '/Muzo_privacy_policy/'));
            // }
          },
          title: Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'KumbhSans',
              // fontWeight: FontWeight.bold,
            ),
          ),
          leading: CircleAvatar(
            radius: 20,
            child: Icon(
              Icons.privacy_tip_outlined,
              color: Colors.grey,
            ),
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        settings(
          title: 'Terms & Conditions',
          icon: Icons.gavel,
          toNextPage: () {},
        ),
        SizedBox(
          height: 7,
        ),
        settings(
          title: 'About Us',
          icon: Icons.info_outline,
          toNextPage: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: Color.fromARGB(255, 248, 70, 70),
                      ),
                      Text(
                        'MUZO',
                        style: TextStyle(fontFamily: 'KumbhSans', fontSize: 20),
                      )
                    ],
                  ),
                  content: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'),
                  actions: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        label: Text('OK'))
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
