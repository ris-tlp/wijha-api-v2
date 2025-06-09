// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tourist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tourist _$TouristFromJson(Map<String, dynamic> json) => Tourist(
      userName: json['userName'] as String,
      profilePicture:
          json['profilePicture'] as String? ?? 'assets/logos/wijhaLogo.png',
      travelPoints: json['travelPoints'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
    )
      ..type = json['type'] as String
      ..inTour = json['inTour'] as bool
      ..activeTour = json['activeTour'] == null
          ? null
          : Tour.fromJson(json['activeTour'] as Map<String, dynamic>);

Map<String, dynamic> _$TouristToJson(Tourist instance) => <String, dynamic>{
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'travelPoints': instance.travelPoints,
      'rating': instance.rating,
      'type': instance.type,
      'inTour': instance.inTour,
      'activeTour': instance.activeTour,
    };
