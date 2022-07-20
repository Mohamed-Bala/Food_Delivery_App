import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  //TextOverflow overflow;
  SmallText({
    Key? key,
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.color = const Color(0xFF979797),
    // this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Jannah',
        color: color,
        fontSize: size,
        height: height,
        // overflow: overflow,
      ),
    );
  }
}
