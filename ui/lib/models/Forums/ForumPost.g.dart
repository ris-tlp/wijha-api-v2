// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForumPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumPost _$ForumPostFromJson(Map<String, dynamic> json) => ForumPost(
    creator: User.fromJson(json['creator'] as Map<String, dynamic>),
    date: DateTime.parse(json['timestamp'] as String),
    title: json['title'] as String,
    content: json['content'] as String,
    likes: json['likes'] as int,
    tags: (json['tags'] as List<dynamic>)
        .map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList(),
    comments: json['comments'] as List<dynamic>,
    subforum: Subforum.fromJson(json["subforum"] as Map<String, dynamic>));

Map<String, dynamic> _$ForumPostToJson(ForumPost instance) => <String, dynamic>{
      'isPressed': instance.isPressed,
      'likes': instance.likes,
      'title': instance.title,
      'content': instance.content,
      'creator': instance.creator,
      'date': instance.date.toIso8601String(),
      'comments': instance.comments,
      'tags': instance.tags,
      'subforum': instance.subforum
    };
