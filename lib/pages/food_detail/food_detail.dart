
import 'package:Food_Delivery_App/controller/cart_controller.dart';
import 'package:Food_Delivery_App/routes/route_helper.dart';
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:Food_Delivery_App/utils/constants.dart';
import 'package:Food_Delivery_App/utils/dimension.dart';
import 'package:Food_Delivery_App/widgets/app_column.dart';
import 'package:Food_Delivery_App/widgets/app_icon.dart';
import 'package:Food_Delivery_App/widgets/big_text.dart';
import 'package:Food_Delivery_App/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProdcut(product, Get.find<CartController>());

    return Scaffold(
      //  backgroundColor: Colors.white,
      body: Stack(
        children: [
//__________ Image Section _____________________________________________________
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: Dimensions.foodDetailImgSize,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BAES_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!,
                  ),
                ),
              ),
            ),
          ),
//_________ Icon Header _______________________________________________________________
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios_rounded),
                ),
                GetBuilder<PopularProductController>(
                  builder: ((controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? const Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.kPrimaryColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 4,
                                  top: -1,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
// _______  _____________________________________________________
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.foodDetailImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
//_________________           __________________________________________________
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//******************  Name Food  ********************************************* /
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
//***********  Descrption Text ***********************************************/
                  BigText(text: 'Introduce', color: Colors.black),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
//===========  bottom Navigation Bar Section ===================================
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Container(
            height: Dimensions.bottomBarHeight,
            padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height20,
              bottom: Dimensions.height10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
//____________ First Item   ____________________________________________________
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: const Icon(Icons.remove),
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      SmallText(
                        text: controller.inCartItems.toString(),
                        size: 22,
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
//___________ Secend Item ______________________________________________________
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: GestureDetector(
                    onTap: () => controller.addItem(product),
                    child: BigText(
                      text: '\$ ${product.price} | Add To Cart',
                      color: Colors.white,
                    ),
                  ),
                ),
//____________________________________________________________________________\\
              ],
            ),
          );
        },
      ),
    );
  }
}
