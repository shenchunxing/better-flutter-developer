import 'package:flutter/cupertino.dart';
import 'package:flutter_app/_09_state_manager/model/user_info.dart';

class HYUserViewModel extends ChangeNotifier {
  UserInfo _userInfo;

  HYUserViewModel(this._userInfo);

  UserInfo get userInfo => _userInfo;

  set userInfo(UserInfo value) {
    _userInfo = value;
    notifyListeners();
  }
}