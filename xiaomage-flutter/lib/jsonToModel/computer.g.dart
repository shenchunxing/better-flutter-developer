// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'computer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Computer _$ComputerFromJson(Map<String, dynamic> json) {
  return Computer(
    json['brand'] as String,
    json['price'] as String,
  );
}

Map<String, dynamic> _$ComputerToJson(Computer instance) => <String, dynamic>{
      'brand': instance.brand,
      'price': instance.price,
    };
