import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muzoplayer/screens/home/main_screen.dart';
import 'package:muzoplayer/widgets/drawewidget/about_us.dart';
import 'package:muzoplayer/widgets/drawewidget/privacy_policy.dart';
import 'package:muzoplayer/widgets/drawewidget/terms_&_condition.dart';
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
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PrivacyPolicy(),
            ));
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
          toNextPage: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TermsAndCondition(),
            ));
          },
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
              builder: (context) => const AboutUs(),
            );
          },
        )
      ],
    );
  }
}
