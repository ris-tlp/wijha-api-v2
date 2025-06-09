import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ForumPost.dart';
part 'Subforum.g.dart';

@JsonSerializable()
class Subforum {
  String title;
  String content;
  String imageUrl;
  int totalPosts;
  List<ForumPost> posts;

  Subforum(
      {required this.title,
      required this.content,
      required this.imageUrl,
      required this.posts,
      this.totalPosts = 0});

  /// Creates a ForumPost Object from JSON formatted object
  factory Subforum.fromJson(Map<String, dynamic> json) =>
      _$SubforumFromJson(json);

  /// Converts ForumPost object to JSON format
  Map<String, dynamic> toJson() => _$SubforumToJson(this);

  /// Fetches all the Subforums within the application
  static Future<List<Subforum>> getAllSubforums() async {
    String url = "https://wijha-417.ew.r.appspot.com/forum/subforum";
    var response = await Dio().get(url);

    List<Subforum> subforums = [
      for (var subforum in response.data) Subforum.fromJson(subforum)
    ];

    return subforums;
  }

  /// Fetches all the posts within a specific Subforum
  Future<List<ForumPost>> getAllPostsInSubforum() async {
    String url = "https://wijha-417.ew.r.appspot.com/forum/subforum/post";
    var response = await Dio().post(url,
        data: this.toJson(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    List<ForumPost> posts = [
      for (var post in response.data) ForumPost.fromJson(post)
    ];

    return posts;
  }
}
