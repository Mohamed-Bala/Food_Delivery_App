import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/colors.dart';
import 'package:e_commerce_app/utils/dimension.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../utils/constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProdcut(product, Get.find<CartController>());

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(icon: Icons.clear),
                  ),
                  //const AppIcon(icon: Icons.shopping_cart_outlined),

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
                  ),
                ],
              ),
// _____________ Title  Text ___________________________________________________
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                  child: Center(
                    child: BigText(color: Colors.black, text: product.name!),
                  ),
                ),
              ),
//_______________ Image ________________________________________________________
              pinned: true,
              backgroundColor: Colors.orange[200],
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BAES_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
//____________ Text Section ____________________________________________________
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: ExpandableText(text: product.description!),
                  ),
                ],
              ),
            ),
          ],
        ),
//=============== bottom Navigation Bar ========================================
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: ((controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => controller.setQuantity(false),
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.remove,
                        backgroundColor: AppColors.kPrimaryColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText(
                      text: '\$ ${product.price}  X ${controller.inCartItems}',
                    ),
                    GestureDetector(
                      onTap: () => controller.setQuantity(true),
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.add,
                        backgroundColor: AppColors.kPrimaryColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
//================ Footer Section ==============================================
              Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
//___________ Secend Item ______________________________________________________
                    GestureDetector(
                      onTap: () => controller.addItem(product),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: BigText(
                          text: '\$${product.price!} | Add To Cart',
                          color: Colors.white,
                        ),
                      ),
                    ),
//____________________________________________________________________________\\
                  ],
                ),
              ),
            ],
          );
        })));
  }
}
