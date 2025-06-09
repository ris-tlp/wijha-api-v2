// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guide _$GuideFromJson(Map<String, dynamic> json) => Guide(
      userName: json['userName'] as String,
      profilePicture: json['profilePicture'] as String? ??
          'https://cdn-icons-png.flaticon.com/512/147/147142.png',
      travelPoints: json['travelPoints'] as int? ?? 0,
      rating: double.parse(json["rating"]),
    );
// ..type = json['type'] as String
// ..tourList = (json['tourList'] as List<dynamic>)
//     .map((e) => Tour.fromJson(e as Map<String, dynamic>))
//     .toList()
// ..tourHistoryList = (json['tourHistoryList'] as List<dynamic>)
//     .map((e) => Tour.fromJson(e as Map<String, dynamic>))
//     .toList()
// ..customLocations = (json['customLocations'] as List<dynamic>)
//     .map((e) => CustomLocation.fromJson(e as Map<String, dynamic>))
//     .toList();

Map<String, dynamic> _$GuideToJson(Guide instance) => <String, dynamic>{
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'travelPoints': instance.travelPoints,
      'rating': instance.rating,
      'type': instance.type,
      'tourList': instance.tourList,
      'tourHistoryList': instance.tourHistoryList,
      'customLocations': instance.customLocations,
    };
