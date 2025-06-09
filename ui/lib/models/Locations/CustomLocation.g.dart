// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomLocation _$CustomLocationFromJson(Map<String, dynamic> json) =>
    CustomLocation(
      name: json['name'],
      description: json['description'],
      locationFact: json['locationFact'],
      locationNumber: json['locationNumber'],
      image: json['image'],
      coordinates: json['coordinates'],
    );

Map<String, dynamic> _$CustomLocationToJson(CustomLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'locationFact': instance.locationFact,
      'locationNumber': instance.locationNumber,
      'image': instance.image,
      'coordinates': instance.coordinates,
    };
