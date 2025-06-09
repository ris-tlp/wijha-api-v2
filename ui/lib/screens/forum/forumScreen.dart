import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/providers/forumProvider.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:wijha/widgets/searchWidget.dart';
import '../../models/Forums/Subforum.dart';
import 'forumWidgets/postCard.dart';
import 'forumWidgets/subforumCard.dart';

class ForumScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends ConsumerState<ForumScreen> {
  var textStyle =
      TextStyle(fontFamily: wFont, fontWeight: wBoldWeight, fontSize: 14);
  var textStyle2 = TextStyle(
      fontFamily: wFont,
      fontWeight: wBoldWeight,
      fontSize: 16,
      color: wPrimaryColor);

  String query = '';
  bool init = true;
  bool loading = true;
  List<Subforum>? subforums;
  List<ForumPost>? generalPosts = [];
  List<ForumPost>? displayPosts;
  Future<List<Subforum>>? futureSubforums;
  Future<List<ForumPost>>? futureGeneralPosts;

  @override
  void initState() {
    futureSubforums = Subforum.getAllSubforums();
    futureSubforums!.then((data) => setState(() {
          subforums = data;
        }));

    // futureGeneralPosts = ForumPost.getAllForumPosts();
    // futureGeneralPosts!.then((data) => setState(() {
    //       generalPosts = data;
    //       displayPosts = generalPosts;
    //     }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.longestSide;
    final double width = MediaQuery.of(context).size.width;

    var textStyle =
        TextStyle(fontFamily: wFont, fontSize: 20, fontWeight: wBoldWeight);

    return Consumer(builder: (context, ref, _) {
      final _posts = ref.watch(forumProvider.notifier);

      if (init) {
        _posts.initPosts();
        init = !init;
      }

      generalPosts = _posts.getPosts();
      displayPosts = generalPosts;

      /// Render only if both items have been fetched
      if (subforums != null && displayPosts != null) {
        loading = false;
      }

      return loading
          ? Loading()
          : SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  extendBody: true,
                  backgroundColor: wBackgroundColor,
                  body: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 70,
                          width: width,
                          child: Center(
                            child: SearchWidget(
                              text: query,
                              onChanged: searchPosts,
                              hintText: 'Search posts by title',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: Container(
                          height: 50,
                          width: width,
                          child: TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  'General',
                                  textAlign: TextAlign.left,
                                  style: textStyle,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Subforums',
                                  style: textStyle,
                                ),
                              ),
                            ],
                            padding: EdgeInsets.only(left: 10),
                            indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: true,
                            labelColor: wPrimaryColor,
                            indicatorColor: wPrimaryColor,
                            indicatorWeight: 3,
                            unselectedLabelColor: wGrey,
                            automaticIndicatorColorAdjustment: false,
                            labelPadding: EdgeInsets.only(right: 10, left: 10),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        child: Container(
                          height: height - 150,
                          width: width,
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              // first tab bar view widget
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: wDefaultPadding),
                                  child: Column(
                                    children: [
                                      for (var i = 0;
                                          i < displayPosts!.length;
                                          i++) ...[
                                        SizedBox(height: 5),
                                        PostCard(
                                          post: displayPosts![i],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                      SizedBox(height: 60),
                                    ],
                                  ),
                                ),
                              ),

                              // second tab bar view widget
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: wDefaultPadding),
                                  child: Column(
                                    children: [
                                      for (var i = 0;
                                          i < subforums!.length;
                                          i++) ...[
                                        SizedBox(height: 5),
                                        SubformCard(
                                          forum: subforums![i],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                      SizedBox(height: 60),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  void searchPosts(String query) {
    final result = generalPosts!.where((post) {
      final titleLower = post.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.displayPosts = result;
    });
  }
}
