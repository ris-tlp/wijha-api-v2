// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlogPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPost _$BlogPostFromJson(Map<String, dynamic> json) => BlogPost(
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      likes: json['likes'] as num,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String,
      body: json['body'] as String,
      isPublished: json['isPublished'] as bool? ?? false,
    );

Map<String, dynamic> _$BlogPostToJson(BlogPost instance) => <String, dynamic>{
      'creator': instance.creator,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'likes': instance.likes,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'body': instance.body,
      'isPublished': instance.isPublished,
    };
