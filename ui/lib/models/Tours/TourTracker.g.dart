// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TourTracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourTracker _$TourTrackerFromJson(Map<String, dynamic> json) => TourTracker(
    attending: (json['attending'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    registered: (json['registered'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    currentLocation: json['currentLocation'] as int,
    guide: Guide.fromJson(json['guide'] as Map<String, dynamic>),
    tour: Tour.fromJson(json['tour'] as Map<String, dynamic>),
    id: json["tracker_id"],
    active: json["active"]);

Map<String, dynamic> _$TourTrackerToJson(TourTracker instance) =>
    <String, dynamic>{
      'attending': instance.attending,
      'registered': instance.registered,
      'currentLocation': instance.currentLocation,
      'guide': instance.guide,
      'tour': instance.tour,
      'id': instance.id,
      'active': instance.active
    };
