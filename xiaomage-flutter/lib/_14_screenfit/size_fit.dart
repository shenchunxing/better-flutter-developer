
import 'dart:ui';

class HYSizeFit {
  // 1.基本信息
  static double physicalWidth = 0; //物理宽高
  static double physicalHeight = 0;
  static double screenWidth = 0; //屏幕宽高
  static double screenHeight = 0;
  static double dpr = 0; //比例
  static double statusHeight = 0; //状态栏高度
  static double rpx = 0;
  static double px = 0;

  //初始化
  static void initialize({double standardSize = 750}) {
    // 1.手机的物理分辨率(测试模拟器为iphone8)
    physicalWidth = window.physicalSize.width; //750
    physicalHeight = window.physicalSize.height; //1334

    // 2.获取dpr
    dpr = window.devicePixelRatio; //2
    // 3.宽度和高度
    screenWidth = physicalWidth / dpr; //375
    screenHeight = physicalHeight / dpr; //667
    // 4.状态栏高度
    statusHeight = window.padding.top / dpr; //20
    // 5.计算rpx的大小
    rpx = screenWidth / standardSize; //0.5
    px = screenWidth / standardSize * 2; //比例系数：1

  }

  static double setRpx(double size) {
    return rpx *size;
  }

  static double setPx(double size) {
    return px * size;
  }
}