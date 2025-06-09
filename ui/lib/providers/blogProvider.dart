import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Subforum.dart';

class BlogProvider extends StateNotifier<List<BlogPost>> {
  BlogProvider() : super([]);

  initPosts() {
    // List<List<ForumPost>> a = forumList.map((forum) => forum.posts).toList();
    // // List<List<ForumPost>> a = [];
    // List<ForumPost> list;
    // List<ForumPost> empty = [];
    // for (list in a) {
    //   empty += list;
    // }

    List<BlogPost> temp = [];
    Future<List<BlogPost>>? futureGeneralPosts = BlogPost.getAllBlogPosts();
    futureGeneralPosts.then((data) => temp.addAll(data));
    state = temp;
    state.sort((a, b) => a.date.millisecondsSinceEpoch.compareTo(b.date.millisecondsSinceEpoch));
  }

  getPosts() {
    // _sortPosts();
    return state.toList();
  }

  _sortPosts() {
    state.sort((a, b) => a.date.microsecondsSinceEpoch.compareTo(b.date.microsecondsSinceEpoch));
  }

  addPost(BlogPost post) {
    bool? response = true;
    post.createBlogPost().then((value) => response = value);
    print(response);
    if (response!) {
      state.add(post);
      state.sort((a, b) => a.date.millisecondsSinceEpoch
          .compareTo(b.date.millisecondsSinceEpoch));
    }
  }
}

final blogProvider = StateNotifierProvider<BlogProvider, List<BlogPost>>(
        (ref) => BlogProvider());
