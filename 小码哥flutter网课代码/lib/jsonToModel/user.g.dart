// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['email'] as String,
    json['register_date'] as String,
    (json['courses'] as List).map((e) => e as String).toList(),
    json['computer'] == null
        ? null
        : Computer.fromJson(json['computer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'register_date': instance.registerDate,
      'courses': instance.courses,
      'computer': instance.computer,
    };
