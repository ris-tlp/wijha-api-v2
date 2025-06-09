// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String,
      profilePicture: json['profilePicture'] as String? ?? '',
      travelPoints: json['travelPoints'] as int? ?? 0,
      rating: double.parse(json['rating'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'travelPoints': instance.travelPoints,
      'rating': instance.rating,
      'type': instance.type,
    };
