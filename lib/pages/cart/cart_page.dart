import 'package:Food_Delivery_App/controller/cart_controller.dart';
import 'package:Food_Delivery_App/controller/popular_product_controller.dart';
import 'package:Food_Delivery_App/controller/recommended_product_controller.dart';
import 'package:Food_Delivery_App/routes/route_helper.dart';
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:Food_Delivery_App/utils/constants.dart';
import 'package:Food_Delivery_App/utils/dimension.dart';
import 'package:Food_Delivery_App/widgets/app_icon.dart';
import 'package:Food_Delivery_App/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
//================ Header Item =================================================
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.kPrimaryColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.kPrimaryColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.kPrimaryColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
//==================== List Item ===============================================
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller) {
                  var _cart = controller.getItems;
                  return ListView.builder(
                      itemCount: _cart.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
//___________________ check when user tap in the item in the cart ______________
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cart[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(
                                      RouteHelper.getPopularFood(
                                          popularIndex, 'cartpage'),
                                    );
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cart[index].product!);
                                    Get.toNamed(
                                      RouteHelper.getRecommendedFood(
                                          recommendedIndex, 'cartpage'),
                                    );
                                  }
//______________________________________________________________________________
                                },
                                child: Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.height10,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BAES_URL +
                                            AppConstants.UPLOAD_URL +
                                            controller.getItems[index].img!,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radius20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              Expanded(
                                child: Container(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: _cart[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: 'Global'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text:
                                                _cart[index].price!.toString(),
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width10,
                                              right: Dimensions.width10,
                                              top: Dimensions.height10,
                                              bottom: Dimensions.height10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimensions.radius20,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.addItem(
                                                      _cart[index].product!,
                                                      -1,
                                                    );
                                                  },
                                                  child:
                                                      const Icon(Icons.remove),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                SmallText(
                                                  text: _cart[index]
                                                      .quantity
                                                      .toString(),
                                                  size: 22,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.addItem(
                                                      _cart[index].product!,
                                                      1,
                                                    );
                                                  },
                                                  child: const Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        ],
      ),
      //===========  bottom Navigation Bar Section ===================================
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartcontroller) {
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
                      SizedBox(width: Dimensions.width10 / 2),
                      SmallText(
                        text: '\$ ' + cartcontroller.totalAmount.toString(),
                        size: 22,
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                    ],
                  ),
                ),
//___________ Secend Item ______________________________________________________
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: BigText(
                      text: 'Check Out',
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
