import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'dart:io';

part 'BlogPost.g.dart';

@JsonSerializable()
class BlogPost {
  User creator;
  DateTime date;
  String title;
  num likes;
  List<Tag> tags;
  String imageUrl;
  String body;
  bool isPublished;

  BlogPost({
    required this.creator,
    required this.date,
    required this.title,
    required this.likes,
    required this.tags,
    required this.imageUrl,
    required this.body,
    this.isPublished = false,
  });

  /// Creates a BlogPost Object from JSON formatted object
  factory BlogPost.fromJson(Map<String, dynamic> json) =>
      _$BlogPostFromJson(json);

  /// Converts BlogPost object to JSON format
  Map<String, dynamic> toJson() => _$BlogPostToJson(this);

  /// Sends a GET request to fetch all the BlogPosts
  static Future<List<BlogPost>> getAllBlogPosts() async {
    String url = "https://wijha-417.ew.r.appspot.com/blog/post";
    var response = await Dio().get(url);

    List<BlogPost> blogPosts = [
      for (var post in response.data) BlogPost.fromJson(post)
    ];

    return blogPosts;
  }

  /// Sends a POST request to create a new BlogPost
  Future<bool> createBlogPost() async {
    String url = "https://wijha-417.ew.r.appspot.com/blog/post/create";
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

  static uploadImageBucket(XFile image) async {
    late String image_url;
    String image_name = image.name;
    // String url = "https://wijha-417.ew.r.appspot.com/upload-image";
    String url = "https://wijha-417.ew.r.appspot.com/upload-image";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var encoded_image = base64.encode(await File(image.path).readAsBytes());

    request.fields["name"] = image_name;
    request.fields["mimetype"] = "image/jpeg";
    request.fields["entity"] = "BlogPost";
    request.files.add(http.MultipartFile.fromString("image", encoded_image));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    image_url = jsonDecode(responseString)["URL"];

    return image_url;
  }
}
