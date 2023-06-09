import 'package:flutter/material.dart';

class RemovePopUp extends StatelessWidget {
  VoidCallback onpressedClicked;

  RemovePopUp({super.key, required this.onpressedClicked});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: const Text('PLEASE CONFIRM DELETION'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: onpressedClicked,
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          label: const Text(
                            'YES',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'NO',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ))
                    ],
                  ),
                ],
              );
            }));
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          const PopupMenuItem(
            value: 0,
            child: Text('Remove Song'),
          ),
        ];
      },
    );
  }
}
