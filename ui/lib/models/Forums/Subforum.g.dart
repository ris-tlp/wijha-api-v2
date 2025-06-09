// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Subforum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subforum _$SubforumFromJson(Map<String, dynamic> json) => Subforum(
    title: json['title'] as String,
    content: json['content'] as String,
    imageUrl: json['imageUrl'] as String,
    totalPosts: json["totalPosts"] as int,
    posts: []
    // posts: (json['posts'] as List<dynamic>)
    //     .map((e) => ForumPost.fromJson(e as Map<String, dynamic>))
    //     .toList(),
    );

Map<String, dynamic> _$SubforumToJson(Subforum instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      "totalPosts": instance.totalPosts
      // 'posts': instance.posts,
    };
