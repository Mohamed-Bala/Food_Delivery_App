
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:Food_Delivery_App/utils/dimension.dart';
import 'package:Food_Delivery_App/widgets/big_text.dart';
import 'package:Food_Delivery_App/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'slider_page.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print("Height is " + MediaQuery.of(context).size.height.toString());
    // print("width is " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.height45,
              bottom: Dimensions.height15,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Sudan',
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'City',
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            size: Dimensions.iconSize24,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: SliderPage(),
            ),
          )
        ],
      ),
    );
  }
}
