
import 'package:flutter_app/_14_screenfit/size_fit.dart';

extension DoubleFit on double {
  double get px {
     return HYSizeFit.setPx(this);
  }

  double get rpx {
    return HYSizeFit.setRpx(this);
  }
}