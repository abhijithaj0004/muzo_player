import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class Ellipse extends StatelessWidget {
  final Color color;
  const Ellipse({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
