import 'package:json_annotation/json_annotation.dart';

part'computer.g.dart';
@JsonSerializable()
class Computer {
  String? brand;
  String? price;

  Computer(this.brand,this.price);

  factory Computer.fromJson(Map<String,dynamic> json) {
    return  _$ComputerFromJson(json);
  }

  Map<String,dynamic> toJson() {
    return _$ComputerToJson(this);
  }

  @override
  String toString() {
    return'Computer{brand: $brand, price: $price}';
  }
}