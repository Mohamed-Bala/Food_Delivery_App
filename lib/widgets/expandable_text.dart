import 'package:e_commerce_app/utils/colors.dart';
import 'package:e_commerce_app/utils/dimension.dart';
import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondtHalf;

  bool hidden = true;

  double textHeight = Dimensions.screenHeight / 5.62;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondtHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondtHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondtHalf.isEmpty
          ? SmallText(size: Dimensions.font16, text: firstHalf)
          : Column(
              children: [
                SmallText(
                   height: 1.8,
                  size: Dimensions.font16,
                  text: hidden ? firstHalf + '...' : (firstHalf + secondtHalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hidden ? 'Show more' : 'Show less',
                        color: AppColors.kPrimaryColor,
                      ),
                      Icon(
                        hidden
                            ? Icons.arrow_drop_down_rounded
                            : Icons.arrow_drop_up_rounded,
                        color: AppColors.kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
