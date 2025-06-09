import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/User.dart';

import 'Tag.dart';
part 'ForumPost.g.dart';

@JsonSerializable()
class ForumPost {
  bool isPressed = false;
  int likes;
  static int travelPoints = 20;
  String title;
  String content;
  User creator;
  DateTime date;
  List comments;
  List<Tag> tags;
  Subforum subforum;

  ForumPost(
      {required this.creator,
      required this.date,
      required this.title,
      required this.content,
      required this.likes,
      required this.tags,
      required this.comments,
      required this.subforum});

  /// Creates a ForumPost Object from JSON formatted object
  factory ForumPost.fromJson(Map<String, dynamic> json) =>
      _$ForumPostFromJson(json);

  /// Converts ForumPost object to JSON format
  Map<String, dynamic> toJson() => _$ForumPostToJson(this);

  /// Creates a POST request to the API to create a new ForumPost
  Future<bool> createPost() async {
    inspect(this);
    String url =
        "https://wijha-417.ew.r.appspot.com/forum/subforum/post/create";

    // String url = "http://192.168.100.14:8080/forum/subforum/post/create";
    Map<String, dynamic> postJson = this.toJson();

    try {
      var response = await Dio().post(url,
          data: postJson,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      print(response);
      return true;
    } catch (exception) {
      return false;
    }
  }

  /// Creates a POST request to the API to add a new comment to the ForumPost
  createComment(ForumPost parentPost) async {
    String url =
        "https://wijha-417.ew.r.appspot.com/forum/subforum/comment/create";
    var data = {
      "parent": parentPost.toJson(),
      "comment": this.toJson(),
    };

    var response = await Dio().post(url,
        data: data,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    print(response.data);
  }

  /// Creates a POST request to the API to get all the comments of a ForumPost
  Future<List<ForumPost>> getAllCommentsOfPost() async {
    String url = "https://wijha-417.ew.r.appspot.com/forum/subforum/comment";
    Map<String, dynamic> postJson = this.toJson();

    var response = await Dio().post(url,
        data: postJson,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}));

    List<ForumPost> comments = [
      for (var comment in response.data) ForumPost.fromJson(comment)
    ];

    return comments;
  }

  /// Gets all the posts made to view in the general forums page
  static Future<List<ForumPost>> getAllForumPosts() async {
    String url = "https://wijha-417.ew.r.appspot.com/forum/general/post";
    var response = await Dio().get(url);

    List<ForumPost> posts = [
      for (var post in response.data) ForumPost.fromJson(post)
    ];

    return posts;
  }
}

// CircleAvatar(
//         foregroundImage: NetworkImage('https://picsum.photos/id/1019/300/30'),
//         backgroundColor: wPrimaryColor,
//         radius: 22,
//       ),

