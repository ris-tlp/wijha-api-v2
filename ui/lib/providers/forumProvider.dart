import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Subforum.dart';

class ForumProvider extends StateNotifier<List<ForumPost>> {
  ForumProvider() : super([]);

  initPosts() {
    // List<List<ForumPost>> a = forumList.map((forum) => forum.posts).toList();
    // // List<List<ForumPost>> a = [];
    // List<ForumPost> list;
    // List<ForumPost> empty = [];
    // for (list in a) {
    //   empty += list;
    // }

    List<ForumPost> temp = [];
    Future<List<ForumPost>>? futureGeneralPosts = ForumPost.getAllForumPosts();
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

  getPostsBySubforum(Subforum subforum) {
    return state.where((post) => post.subforum.title == subforum.title).toList();
  }

  // static _checkUpdates() {
  // }
  //
  // List<ForumPost> getPostBySubforum(Subforum forum) {
  //   return forum.posts;
  // }

  // List<ForumPost> getTempPosts() {
  //   return riyadhPosts;
  // }

  addPost(ForumPost post) {
    bool? response = true;
    post.createPost().then((value) => response = value);
    print(response);
    if (response!) {
      state.add(post);
      state.sort((a, b) => a.date.millisecondsSinceEpoch
          .compareTo(b.date.millisecondsSinceEpoch));
    }
  }
}

final forumProvider = StateNotifierProvider<ForumProvider, List<ForumPost>>(
    (ref) => ForumProvider());
