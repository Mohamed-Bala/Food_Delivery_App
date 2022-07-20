import 'package:e_commerce_app/utils/dimension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  //TextOverflow overflow;
  BigText({
    Key? key,
    required this.text,
    this.size = 0,
    //this.overflow = TextOverflow.ellipsis,
    this.color = Colors.black,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'Jannah',
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
        // overflow: overflow,
        height: height,
      ),
    );
  }
}
