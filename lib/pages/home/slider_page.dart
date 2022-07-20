import 'package:Food_Delivery_App/controller/popular_product_controller.dart';
import 'package:Food_Delivery_App/controller/recommended_product_controller.dart';
import 'package:Food_Delivery_App/models/products_model.dart';
import 'package:Food_Delivery_App/routes/route_helper.dart';
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:Food_Delivery_App/utils/constants.dart';
import 'package:Food_Delivery_App/utils/dimension.dart';
import 'package:Food_Delivery_App/widgets/app_column.dart';
import 'package:Food_Delivery_App/widgets/big_text.dart';
import 'package:Food_Delivery_App/widgets/icon_and_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.imageContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (controller) {
          return controller.isLoading
              ? Container(
                  // color: Colors.red,
                  height: Dimensions.mainContainer,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: controller.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                            position, controller.popularProductList[position]);
                      }),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                );
        }),
//_________ Dots_Indicator _____________________________________________________
        GetBuilder<PopularProductController>(builder: (controller) {
          return DotsIndicator(
            dotsCount: controller.popularProductList.isEmpty
                ? 1
                : controller.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.kPrimaryColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
        }),
//______________________________________________________________________________
        SizedBox(height: Dimensions.height30),
//============= Recommended Section ================================================
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
            ],
          ),
        ),
//_______________ List Of Food && Image ________________________________________
        GetBuilder<RecommendedProductController>(
          builder: (controller) {
            return controller.isLoading
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.recommendedProductList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height20,
                        ),
                        child: Row(
                          children: [
//__________________  Image Section ____________________________________________
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BAES_URL +
                                        AppConstants.UPLOAD_URL +
                                        controller
                                            .recommendedProductList[index].img!,
                                  ),
                                ),
                              ),
                            ),
//_________________ Text Container  ____________________________________________
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewContainerSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: controller
                                            .recommendedProductList[index]
                                            .name!,
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Text(
                                        controller.recommendedProductList[index]
                                            .description!,
                                        style: const TextStyle(
                                          fontFamily: 'Jannah',
                                          fontSize: 12,
                                          height: 1.2,
                                          color: Color(0xFF979797),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  );
          },
        )
      ],
    );
  }

  Widget _buildPageItem(int index, Products model) {
//______________________________________________________________________________
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
//______________________________________________________________________________
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
//____________ Image Item ______________________________________________________
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.imageContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Colors.teal : Colors.amber,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BAES_URL +
                        AppConstants.UPLOAD_URL +
                        model.img!,
                  ),
                ),
              ),
            ),
          ),
//____________ Card Item________________________________________________________
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.cardContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                  top: Dimensions.height10,
                ),
                child: AppColumn(
                  text: model.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
