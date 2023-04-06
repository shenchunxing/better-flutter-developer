// To parse this JSON data, do
//
//     final hyDetailModel = hyDetailModelFromJson(jsonString);

import 'dart:convert';

HyDetailModel hyDetailModelFromJson(String str) => HyDetailModel.fromJson(json.decode(str));

String hyDetailModelToJson(HyDetailModel data) => json.encode(data.toJson());

class HyDetailModel {
  String? iid;
  Result? result;
  Status? status;

  HyDetailModel({
    this.iid,
    this.result,
    this.status,
  });

  factory HyDetailModel.fromJson(Map<String, dynamic> json) => HyDetailModel(
    iid: json["iid"],
    result: Result.fromJson(json["result"]),
    status: Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "iid": iid,
    "result": result?.toJson(),
    "status": status?.toJson(),
  };
}

class Result {
  List<String>? columns;
  DetailInfo? detailInfo;
  String? esi;
  bool? isLogin;
  ItemInfo? itemInfo;
  ItemParams? itemParams;
  Promotions? promotions;
  Rate? rate;
  ShopInfo? shopInfo;
  SkuInfo? skuInfo;
  TopBar? topBar;

  Result({
    this.columns,
    this.detailInfo,
    this.esi,
    this.isLogin,
    this.itemInfo,
    this.itemParams,
    this.promotions,
    this.rate,
    this.shopInfo,
    this.skuInfo,
    this.topBar,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    columns: List<String>.from(json["columns"].map((x) => x)),
    detailInfo: DetailInfo.fromJson(json["detailInfo"]),
    esi: json["esi"],
    isLogin: json["isLogin"],
    itemInfo: ItemInfo.fromJson(json["itemInfo"]),
    itemParams: ItemParams.fromJson(json["itemParams"]),
    promotions: Promotions.fromJson(json["promotions"]),
    rate: Rate.fromJson(json["rate"]),
    shopInfo: ShopInfo.fromJson(json["shopInfo"]),
    skuInfo: SkuInfo.fromJson(json["skuInfo"]),
    topBar: TopBar.fromJson(json["topBar"]),
  );

  Map<String, dynamic> toJson() => {
    "columns": List<dynamic>.from(columns!.map((x) => x)),
    "detailInfo": detailInfo?.toJson(),
    "esi": esi,
    "isLogin": isLogin,
    "itemInfo": itemInfo?.toJson(),
    "itemParams": itemParams?.toJson(),
    "promotions": promotions?.toJson(),
    "rate": rate?.toJson(),
    "shopInfo": shopInfo?.toJson(),
    "skuInfo": skuInfo?.toJson(),
    "topBar": topBar?.toJson(),
  };
}

class DetailInfo {
  String? desc;
  List<DetailImage>? detailImage;

  DetailInfo({
    this.desc,
    this.detailImage,
  });

  factory DetailInfo.fromJson(Map<String, dynamic> json) => DetailInfo(
    desc: json["desc"],
    detailImage: List<DetailImage>.from(json["detailImage"].map((x) => DetailImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "detailImage": List<dynamic>.from(detailImage!.map((x) => x.toJson())),
  };
}

class DetailImage {
  String? anchor;
  String? desc;
  String? key;
  List<String>? list;

  DetailImage({
    this.anchor,
    this.desc,
    this.key,
    this.list,
  });

  factory DetailImage.fromJson(Map<String, dynamic> json) => DetailImage(
    anchor: json["anchor"],
    desc: json["desc"],
    key: json["key"],
    list: List<String>.from(json["list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "anchor": anchor,
    "desc": desc,
    "key": key,
    "list": List<dynamic>.from(list!.map((x) => x)),
  };
}

class ItemInfo {
  bool? addCartTips;
  bool? admin;
  int? cFav;
  int? cartNum;
  String? cids;
  String? desc;
  String? discountBgColor;
  String? discountDesc;
  Extra? extra;
  String? highNowPrice;
  String? highPrice;
  String? iid;
  String? imUrl;
  bool? inActivity;
  bool? isFaved;
  bool? isGrayUser;
  bool? isNewComer;
  bool? isSelf;
  String? lowNowPrice;
  String? lowPrice;
  String? oldPrice;
  String? price;
  bool? redPacketsSwitch;
  int? saleType;
  String? shopId;
  int? state;
  String? tags;
  String? title;
  List<String>? topImages;
  String? userId;

  ItemInfo({
    this.addCartTips,
    this.admin,
    this.cFav,
    this.cartNum,
    this.cids,
    this.desc,
    this.discountBgColor,
    this.discountDesc,
    this.extra,
    this.highNowPrice,
    this.highPrice,
    this.iid,
    this.imUrl,
    this.inActivity,
    this.isFaved,
    this.isGrayUser,
    this.isNewComer,
    this.isSelf,
    this.lowNowPrice,
    this.lowPrice,
    this.oldPrice,
    this.price,
    this.redPacketsSwitch,
    this.saleType,
    this.shopId,
    this.state,
    this.tags,
    this.title,
    this.topImages,
    this.userId,
  });

  factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
    addCartTips: json["addCartTips"],
    admin: json["admin"],
    cFav: json["cFav"],
    cartNum: json["cartNum"],
    cids: json["cids"],
    desc: json["desc"],
    discountBgColor: json["discountBgColor"],
    discountDesc: json["discountDesc"],
    extra: Extra.fromJson(json["extra"]),
    highNowPrice: json["highNowPrice"],
    highPrice: json["highPrice"],
    iid: json["iid"],
    imUrl: json["imUrl"],
    inActivity: json["inActivity"],
    isFaved: json["isFaved"],
    isGrayUser: json["isGrayUser"],
    isNewComer: json["isNewComer"],
    isSelf: json["isSelf"],
    lowNowPrice: json["lowNowPrice"],
    lowPrice: json["lowPrice"],
    oldPrice: json["oldPrice"],
    price: json["price"],
    redPacketsSwitch: json["redPacketsSwitch"],
    saleType: json["saleType"],
    shopId: json["shopId"],
    state: json["state"],
    tags: json["tags"],
    title: json["title"],
    topImages: List<String>.from(json["topImages"].map((x) => x)),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "addCartTips": addCartTips,
    "admin": admin,
    "cFav": cFav,
    "cartNum": cartNum,
    "cids": cids,
    "desc": desc,
    "discountBgColor": discountBgColor,
    "discountDesc": discountDesc,
    "extra": extra?.toJson(),
    "highNowPrice": highNowPrice,
    "highPrice": highPrice,
    "iid": iid,
    "imUrl": imUrl,
    "inActivity": inActivity,
    "isFaved": isFaved,
    "isGrayUser": isGrayUser,
    "isNewComer": isNewComer,
    "isSelf": isSelf,
    "lowNowPrice": lowNowPrice,
    "lowPrice": lowPrice,
    "oldPrice": oldPrice,
    "price": price,
    "redPacketsSwitch": redPacketsSwitch,
    "saleType": saleType,
    "shopId": shopId,
    "state": state,
    "tags": tags,
    "title": title,
    "topImages": List<dynamic>.from(topImages!.map((x) => x)),
    "userId": userId,
  };
}

class Extra {
  int? deliveryTime;
  String? sendAddress;

  Extra({
    this.deliveryTime,
    this.sendAddress,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    deliveryTime: json["deliveryTime"],
    sendAddress: json["sendAddress"],
  );

  Map<String, dynamic> toJson() => {
    "deliveryTime": deliveryTime,
    "sendAddress": sendAddress,
  };
}

class ItemParams {
  Info? info;
  Rule? rule;

  ItemParams({
    this.info,
    this.rule,
  });

  factory ItemParams.fromJson(Map<String, dynamic> json) => ItemParams(
    info: Info.fromJson(json["info"]),
    rule: Rule.fromJson(json["rule"]),
  );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "rule": rule?.toJson(),
  };
}

class Info {
  String? anchor;
  String? key;
  List<Set>? infoSet;

  Info({
    this.anchor,
    this.key,
    this.infoSet,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    anchor: json["anchor"],
    key: json["key"],
    infoSet: List<Set>.from(json["set"].map((x) => Set.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "anchor": anchor,
    "key": key,
    "set": List<dynamic>.from(infoSet!.map((x) => x.toJson())),
  };
}

class Set {
  String? key;
  String? value;

  Set({
    this.key,
    this.value,
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class Rule {
  String? anchor;
  String? disclaimer;
  String? key;
  List<List<List<String>>>? tables;

  Rule({
    this.anchor,
    this.disclaimer,
    this.key,
    this.tables,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    anchor: json["anchor"],
    disclaimer: json["disclaimer"],
    key: json["key"],
    tables: List<List<List<String>>>.from(json["tables"].map((x) => List<List<String>>.from(x.map((x) => List<String>.from(x.map((x) => x)))))),
  );

  Map<String, dynamic> toJson() => {
    "anchor": anchor,
    "disclaimer": disclaimer,
    "key": key,
    "tables": List<dynamic>.from(tables!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
  };
}

class Promotions {
  AlertData? alertData;
  String? link;
  List<String>? list;

  Promotions({
    this.alertData,
    this.link,
    this.list,
  });

  factory Promotions.fromJson(Map<String, dynamic> json) => Promotions(
    alertData: AlertData.fromJson(json["alertData"]),
    link: json["link"],
    list: List<String>.from(json["list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "alertData": alertData?.toJson(),
    "link": link,
    "list": List<dynamic>.from(list!.map((x) => x)),
  };
}

class AlertData {
  AlertData();

  factory AlertData.fromJson(Map<String, dynamic> json) => AlertData(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Rate {
  int? cRate;
  List<RateList>? list;

  Rate({
    this.cRate,
    this.list,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
    cRate: json["cRate"],
    list: List<RateList>.from(json["list"].map((x) => RateList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cRate": cRate,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class RateList {
  bool? canExplain;
  String? content;
  int? created;
  List<String>? extraInfo;
  List<String>? images;
  int? isAnonymous;
  int? isEmpty;
  String? level;
  String? rateId;
  String? style;
  User? user;

  RateList({
    this.canExplain,
    this.content,
    this.created,
    this.extraInfo,
    this.images,
    this.isAnonymous,
    this.isEmpty,
    this.level,
    this.rateId,
    this.style,
    this.user,
  });

  factory RateList.fromJson(Map<String, dynamic> json) => RateList(
    canExplain: json["canExplain"],
    content: json["content"],
    created: json["created"],
    extraInfo: List<String>.from(json["extraInfo"].map((x) => x)),
    images: List<String>.from(json["images"].map((x) => x)),
    isAnonymous: json["isAnonymous"],
    isEmpty: json["isEmpty"],
    level: json["level"],
    rateId: json["rateId"],
    style: json["style"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "canExplain": canExplain,
    "content": content,
    "created": created,
    "extraInfo": List<dynamic>.from(extraInfo!.map((x) => x)),
    "images": List<dynamic>.from(images!.map((x) => x)),
    "isAnonymous": isAnonymous,
    "isEmpty": isEmpty,
    "level": level,
    "rateId": rateId,
    "style": style,
    "user": user?.toJson(),
  };
}

class User {
  String? avatar;
  String? profileUrl;
  String? tagIndex;
  String? uid;
  String? uname;

  User({
    this.avatar,
    this.profileUrl,
    this.tagIndex,
    this.uid,
    this.uname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    avatar: json["avatar"],
    profileUrl: json["profileUrl"],
    tagIndex: json["tagIndex"],
    uid: json["uid"],
    uname: json["uname"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "profileUrl": profileUrl,
    "tagIndex": tagIndex,
    "uid": uid,
    "uname": uname,
  };
}

class ShopInfo {
  String? allGoodsUrl;
  int? cFans;
  int? cGoods;
  int? cSells;
  List<Category>? categories;
  bool? isMarked;
  int? level;
  String? name;
  bool? nonsupportReasonRefound;
  List<Score>? score;
  List<Service>? services;
  String? shopId;
  String? shopLogo;
  String? shopUrl;
  int? type;
  String? userId;

  ShopInfo({
    this.allGoodsUrl,
    this.cFans,
    this.cGoods,
    this.cSells,
    this.categories,
    this.isMarked,
    this.level,
    this.name,
    this.nonsupportReasonRefound,
    this.score,
    this.services,
    this.shopId,
    this.shopLogo,
    this.shopUrl,
    this.type,
    this.userId,
  });

  factory ShopInfo.fromJson(Map<String, dynamic> json) => ShopInfo(
    allGoodsUrl: json["allGoodsUrl"],
    cFans: json["cFans"],
    cGoods: json["cGoods"],
    cSells: json["cSells"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    isMarked: json["isMarked"],
    level: json["level"],
    name: json["name"],
    nonsupportReasonRefound: json["nonsupportReasonRefound"],
    score: List<Score>.from(json["score"].map((x) => Score.fromJson(x))),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    shopId: json["shopId"],
    shopLogo: json["shopLogo"],
    shopUrl: json["shopUrl"],
    type: json["type"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "allGoodsUrl": allGoodsUrl,
    "cFans": cFans,
    "cGoods": cGoods,
    "cSells": cSells,
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "isMarked": isMarked,
    "level": level,
    "name": name,
    "nonsupportReasonRefound": nonsupportReasonRefound,
    "score": List<dynamic>.from(score!.map((x) => x.toJson())),
    "services": List<dynamic>.from(services!.map((x) => x.toJson())),
    "shopId": shopId,
    "shopLogo": shopLogo,
    "shopUrl": shopUrl,
    "type": type,
    "userId": userId,
  };
}

class Category {
  String? link;
  String? name;

  Category({
    this.link,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    link: json["link"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "name": name,
  };
}

class Score {
  bool? isBetter;
  String? name;
  double? score;

  Score({
    this.isBetter,
    this.name,
    this.score,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    isBetter: json["isBetter"],
    name: json["name"],
    score: json["score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "isBetter": isBetter,
    "name": name,
    "score": score,
  };
}

class Service {
  String? icon;
  String? name;

  Service({
    this.icon,
    this.name,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    icon: json["icon"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "name": name,
  };
}

class SkuInfo {
  String? defaultPrice;
  bool? isAbroad;
  String? priceRange;
  List<Prop>? props;
  String? sizeKey;
  List<Skus>? skus;
  String? styleKey;
  String? title;
  int? totalStock;

  SkuInfo({
    this.defaultPrice,
    this.isAbroad,
    this.priceRange,
    this.props,
    this.sizeKey,
    this.skus,
    this.styleKey,
    this.title,
    this.totalStock,
  });

  factory SkuInfo.fromJson(Map<String, dynamic> json) => SkuInfo(
    defaultPrice: json["defaultPrice"],
    isAbroad: json["isAbroad"],
    priceRange: json["priceRange"],
    props: List<Prop>.from(json["props"].map((x) => Prop.fromJson(x))),
    sizeKey: json["sizeKey"],
    skus: List<Skus>.from(json["skus"].map((x) => Skus.fromJson(x))),
    styleKey: json["styleKey"],
    title: json["title"],
    totalStock: json["totalStock"],
  );

  Map<String, dynamic> toJson() => {
    "defaultPrice": defaultPrice,
    "isAbroad": isAbroad,
    "priceRange": priceRange,
    "props": List<dynamic>.from(props!.map((x) => x.toJson())),
    "sizeKey": sizeKey,
    "skus": List<dynamic>.from(skus!.map((x) => x.toJson())),
    "styleKey": styleKey,
    "title": title,
    "totalStock": totalStock,
  };
}

class Prop {
  bool? isDefault;
  String? label;
  List<PropList>? list;

  Prop({
    this.isDefault,
    this.label,
    this.list,
  });

  factory Prop.fromJson(Map<String, dynamic> json) => Prop(
    isDefault: json["isDefault"],
    label: json["label"],
    list: List<PropList>.from(json["list"].map((x) => PropList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isDefault": isDefault,
    "label": label,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class PropList {
  int? index;
  bool? isDefault;
  String? name;
  int? styleId;
  String? type;
  int? sizeId;

  PropList({
    this.index,
    this.isDefault,
    this.name,
    this.styleId,
    this.type,
    this.sizeId,
  });

  factory PropList.fromJson(Map<String, dynamic> json) => PropList(
    index: json["index"],
    isDefault: json["isDefault"],
    name: json["name"],
    styleId: json["styleId"] == null ? null : json["styleId"],
    type: json["type"],
    sizeId: json["sizeId"] == null ? null : json["sizeId"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "isDefault": isDefault,
    "name": name,
    "styleId": styleId == null ? null : styleId,
    "type": type,
    "sizeId": sizeId == null ? null : sizeId,
  };
}

class Skus {
  Currency? currency;
  String? img;
  int? nowprice;
  int? price;
  String? size;
  int? sizeId;
  int? stock;
  String? stockId;
  Style? style;
  int? styleId;
  String? xdSkuId;

  Skus({
    this.currency,
    this.img,
    this.nowprice,
    this.price,
    this.size,
    this.sizeId,
    this.stock,
    this.stockId,
    this.style,
    this.styleId,
    this.xdSkuId,
  });

  factory Skus.fromJson(Map<String, dynamic> json) => Skus(
    currency: currencyValues.map[json["currency"]],
    img: json["img"],
    nowprice: json["nowprice"],
    price: json["price"],
    size: json["size"],
    sizeId: json["sizeId"],
    stock: json["stock"],
    stockId: json["stockId"],
    style: styleValues.map[json["style"]],
    styleId: json["styleId"],
    xdSkuId: json["xdSkuId"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currencyValues.reverse?[currency],
    "img": img,
    "nowprice": nowprice,
    "price": price,
    "size": size,
    "sizeId": sizeId,
    "stock": stock,
    "stockId": stockId,
    "style": styleValues.reverse?[style],
    "styleId": styleId,
    "xdSkuId": xdSkuId,
  };
}

enum Currency { EMPTY }

final currencyValues = EnumValues({
  "￥": Currency.EMPTY
});

enum Style { EMPTY, STYLE, PURPLE, FLUFFY }

final styleValues = EnumValues({
  "白色": Style.EMPTY,
  "卡其色": Style.FLUFFY,
  "蓝色": Style.PURPLE,
  "粉红色": Style.STYLE
});

class TopBar {
  String? img;
  String? link;

  TopBar({
    this.img,
    this.link,
  });

  factory TopBar.fromJson(Map<String, dynamic> json) => TopBar(
    img: json["img"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "link": link,
  };
}

class Status {
  int? code;
  String? msg;

  Status({
    this.code,
    this.msg,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
