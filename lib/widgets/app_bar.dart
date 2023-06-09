import 'package:flutter/material.dart';
import 'package:muzoplayer/screens/search/search_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool iconnButton;

  CustomAppBar({super.key, required this.title, this.iconnButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
            },
            icon: iconnButton
                ? Icon(Icons.search)
                : SizedBox(
                    width: 40,
                  ))
      ],
    );
  }
}
