// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      imageNet: true,
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
