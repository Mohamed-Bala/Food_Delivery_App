
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:Food_Delivery_App/utils/dimension.dart';
import 'package:Food_Delivery_App/widgets/big_text.dart';
import 'package:Food_Delivery_App/widgets/icon_and_text.dart';
import 'package:Food_Delivery_App/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font20,
        ),
        SizedBox(height: Dimensions.height10 / 2),
//___________ Star Item ________________________________________________________
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: AppColors.kPrimaryColor,
                  size: 16,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: '4.5',
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: '1277',
            ),
            const SizedBox(width: 5),
            SmallText(
              text: 'comments',
            ),
          ],
        ),
        SizedBox(height: Dimensions.height20),
//________________ Icon && Text Item ___________________________________________
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IconAndText(
              icon: Icons.circle_sharp,
              iconColor: Colors.amber,
              text: 'Normal',
            ),
            const IconAndText(
              icon: Icons.location_on,
              iconColor: AppColors.kPrimaryColor,
              text: '1.8kw',
            ),
            const IconAndText(
              icon: Icons.access_time_rounded,
              iconColor: Colors.redAccent,
              text: '30min',
            ),
          ],
        ),
      ],
    );
  }
}
