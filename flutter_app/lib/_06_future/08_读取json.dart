import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

main() {

  getAnchors().then((anchors) {
     print(anchors);
  });
}

class Anchor {
  String nickname = '';
  String rootName = '';
  String imageURL = '';

  Anchor(this.nickname,this.rootName,this.imageURL);

  //字典转模型
  Anchor.withMap(Map<String,dynamic> parseMap) {
     this.nickname = parseMap["nickname"];
     this.rootName = parseMap["rootName"];
     this.imageURL = parseMap["imageURL"];
  }
}

Future <List<Anchor>> getAnchors() async {
  //读取json文件
  String jsonString = await rootBundle.loadString('assets/yz.json');
  //转成map类型
  final jsonResult = json.decode(jsonString);
  List<Anchor> anchors = [];
  //遍历
  for (Map<String , dynamic> map in jsonResult) {
    anchors.add(Anchor.withMap(map));
  }

  return anchors;
}