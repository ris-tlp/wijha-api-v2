// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String? ?? '',
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'user': instance.user,
      'rating': instance.rating,
      'comment': instance.comment,
    };
