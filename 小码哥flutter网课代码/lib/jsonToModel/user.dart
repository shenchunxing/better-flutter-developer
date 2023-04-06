import 'computer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; //这个是之后json_serializable会自动帮助我们生成的文件
@JsonSerializable() //注解：告诉json_serializable哪一个类需要进行转换
class User {
  String? name;
  String? email;
  @JsonKey(name:'register_date')  String? registerDate; //当映射关系不一样时，可以指定映射关系
  List<String> courses;
  Computer? computer;

  User(this.name,this.email,this.registerDate,this.courses,this.computer);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return'User{name: $name, email: $email, registerDate: $registerDate, courses: $courses, computer: $computer}';
  }
}

