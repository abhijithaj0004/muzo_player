import 'package:flutter/material.dart';


Card imageCard(BuildContext context,
    {required String image, required String title}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 8,
    child: Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .38,
          height: MediaQuery.of(context).size.height * .2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .14,
          child: Container(
            width: MediaQuery.of(context).size.width * .38,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: Color.fromARGB(101, 204, 193, 193)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'KumbhSans',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
