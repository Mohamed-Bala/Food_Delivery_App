import 'package:get/get.dart';

class Dimensions {
  // Get The Height && Width Screen
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //
  static double mainContainer = screenHeight / 2.52;
  static double imageContainer = screenHeight / 3.66;
  static double cardContainer = screenHeight / 6.7;

  // dynamic Height padding && margin && Sized Box
  static double height10 = screenHeight / 80.4;
  static double height15 = screenHeight / 53.6;
  static double height20 = screenHeight / 40.2;
  static double height30 = screenHeight / 26.8;
  static double height45 = screenHeight / 17.87;

  // dynamic Width padding && margin && Sized Box
  static double width10 = screenHeight / 80.4;
  static double width15 = screenHeight / 53.6;
  static double width20 = screenHeight / 40.2;
  static double width30 = screenHeight / 26.8;

  // Fonts
  static double font16 = screenHeight / 50.25;
  static double font20 = screenHeight / 40.2;
  static double font26 = screenHeight / 30.92;

  // Icon Size
  static double iconSize24 = screenHeight / 33.5;
  static double iconSize16 = screenHeight / 50.25;

  // Radius
  static double radius15 = screenHeight / 53.6;
  static double radius20 = screenHeight / 40.2;
  static double radius30 = screenHeight / 26.8;

  // List Veiw Size
  static double listViewImgSize = screenWidth / 3.6;
  static double listViewContainerSize = screenWidth / 3.6;

  // Food Detail
  static double foodDetailImgSize = screenHeight / 2.29;

  // bottom Navigation Bar
    static double bottomBarHeight = screenHeight /8.93;


}
