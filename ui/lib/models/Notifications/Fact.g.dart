// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fact _$FactFromJson(Map<String, dynamic> json) => Fact(
      content: json['content'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      expVal: json['expVal'] as int? ?? 25,
    )..type = json['type'] as String;

Map<String, dynamic> _$FactToJson(Fact instance) => <String, dynamic>{
      'location': instance.location,
      'content': instance.content,
      'expVal': instance.expVal,
      'type': instance.type,
    };
