import 'ForumPost.dart';

class Forum{
  String title;
  String description;
  String icon;

  Forum({
    required this.title,
    required this.description,
    required this.icon,
  });

  List<ForumPost> posts = [];
}