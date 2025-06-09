// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      imageNet: true,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => WCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'province': instance.province,
      'imageUrl': instance.imageUrl,
      'categories': instance.categories,
    };
