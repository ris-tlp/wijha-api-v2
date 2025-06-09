// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderedTourLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderedTourLocation _$OrderedTourLocationFromJson(Map<String, dynamic> json) =>
    OrderedTourLocation(
      name: json['name'] as String,
      description: json['description'] as String,
      locationFact: json['locationFact'] as String,
      locationNumber: json['locationNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      coordinates: json['coordinates'] as String,
    );

Map<String, dynamic> _$OrderedTourLocationToJson(
        OrderedTourLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'locationFact': instance.locationFact,
      'locationNumber': instance.locationNumber,
      'imageUrl': instance.imageUrl,
      'coordinates': instance.coordinates,
    };
