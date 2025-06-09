import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Forums/TempPosts.dart';
import 'package:wijha/providers/forumProvider.dart';
import 'package:wijha/screens/forum/createForumPostScreen.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:wijha/widgets/searchWidget.dart';
import 'package:wijha/screens/forum/forumWidgets/postWidget.dart';
import '../../models/Users/User.dart';
import '../../providers/authProvider.dart';
import 'forumWidgets/postCard.dart';
import '../../../models/Users/Guide.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wijha/data.dart';

class SubformScreen extends ConsumerStatefulWidget {
  final Subforum forum;
  final bool init;

  const SubformScreen({Key? key, required this.forum, this.init = true})
      : super(key: key);

  @override
  ConsumerState<SubformScreen> createState() => _SubformScreenState();
}

class _SubformScreenState extends ConsumerState<SubformScreen> {
  List<ForumPost>? posts;
  List<ForumPost>? displayPosts;
  int counter = 0; // 0 for init, 1 for stop
  String query = '';
  int points = ForumPost.travelPoints;
  late ForumPost post;
  List<Tag>? selectedTags;
  final formKey = new GlobalKey<FormState>();
  final titleController = TextEditingController();
  final postController = TextEditingController();

  bool? init;
  bool loading = true;
  Future<List<ForumPost>>? futureDisplayPosts;
  List<Tag>? tags;
  Future<List<Tag>>? futureTags;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    titleController.dispose();
    postController.dispose();
    super.dispose();
  }

  void fetchDisplayPosts() {
    futureDisplayPosts = this.widget.forum.getAllPostsInSubforum();
    futureDisplayPosts!.then((data) => setState(() {
          posts = data;
          displayPosts = posts;
        }));
  }

  /// Fetch all the tags to use in the dropdown on post creation
  void fetchTags() {
    futureTags = Tag.getTagsForPost();
    futureTags!.then((data) => setState(() {
          tags = data;
        }));
  }

  @override
  void initState() {
    super.initState();
    // fetchDisplayPosts();
    init = widget.init;
    fetchTags();
    selectedTags = [];

    // displayPosts = [];

    // displayPosts = [];
    // displayPosts!.add(ForumPost(
    //     creator: Guide(userName: 'Khalid Alamro'),
    //     date: DateTime.now(),
    //     content: "",
    //     title: "",
    //     likes: 0,
    //     tags: [Tag(title: 'Discussion', imageUrl: historicalIcon)],
    //     comments: [],
    //     subforum: this.widget.forum));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      final _posts = ref.watch(forumProvider.notifier);
      User user = _auth.getUser();

      posts = _posts.getPostsBySubforum(widget.forum);
      displayPosts = posts;

      /// Only load page if tags and posts have been fetched successfully
      if (tags != null && displayPosts != null) {
        loading = false;
      }

      return loading
          ? Loading()
          : SafeArea(
              child: Scaffold(
                floatingActionButton: Visibility(
                  visible: user.type == "guest" ? false : true,
                  child: FloatingActionButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ForumPostCreationScreen(
                                  forum: widget.forum)));

                      if (result) {
                        setState(() {});
                      }
                      // showModalBottomSheet<void>(
                      //   isDismissible: false,
                      //   barrierColor: wJetBlack.withOpacity(0.75),
                      //   backgroundColor: wBackgroundColor,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   isScrollControlled: true,
                      //   elevation: 0,
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       height: size.longestSide * 0.90,
                      //       child: Column(children: [
                      //         Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: wDefaultPadding,
                      //               horizontal: wDefaultPadding),
                      //           child: Stack(
                      //             children: <Widget>[
                      //               Center(
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       writeIcon,
                      //                       color: wGrey,
                      //                       height: 20,
                      //                     ),
                      //                     SizedBox(width: 10),
                      //                     Text(
                      //                       "Write a Post",
                      //                       style: TextStyle(
                      //                           fontSize: 16,
                      //                           color: wGrey,
                      //                           fontWeight: FontWeight.w500),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: Container(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: Container(
                      //                     height: 30,
                      //                     width: 30,
                      //                     decoration: BoxDecoration(
                      //                       color: wGrey.withOpacity(0.5),
                      //                       borderRadius: BorderRadius.all(
                      //                         Radius.circular(100),
                      //                       ),
                      //                     ),
                      //                     child: Icon(
                      //                       Icons.close,
                      //                       color: white,
                      //                       size: 20,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(wDefaultPadding),
                      //           child: Column(
                      //             children: [
                      //               TextFormField(
                      //                 controller: titleController,
                      //                 decoration: InputDecoration(
                      //                   labelText: 'Post Title',
                      //                   labelStyle: TextStyle(color: wGrey),
                      //                   focusedBorder: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: wPrimaryColor,
                      //                           width: 1.5)),
                      //                   focusColor: wPrimaryColor,
                      //                   fillColor: white,
                      //                   filled: true,
                      //                   enabled: true,
                      //                   enabledBorder: UnderlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: wGrey, width: 2)),
                      //                 ),
                      //                 maxLength: 25,
                      //               ),
                      //               SizedBox(height: wDefaultPadding),
                      //               Container(
                      //                 height: size.longestSide * 0.2,
                      //                 child: TextFormField(
                      //                   controller: postController,
                      //                   textAlignVertical:
                      //                       TextAlignVertical.top,
                      //                   expands: true,
                      //                   maxLines: null,
                      //                   keyboardType: TextInputType.text,
                      //                   decoration: InputDecoration(
                      //                     floatingLabelBehavior:
                      //                         FloatingLabelBehavior.auto,
                      //                     labelText: "Post Body",
                      //                     labelStyle: TextStyle(color: wGrey),
                      //                     focusedBorder: OutlineInputBorder(
                      //                         borderSide: BorderSide(
                      //                             color: wPrimaryColor,
                      //                             width: 1.5)),
                      //                     focusColor: wPrimaryColor,
                      //                     fillColor: white,
                      //                     filled: true,
                      //                     enabled: true,
                      //                     enabledBorder: UnderlineInputBorder(
                      //                         borderSide: BorderSide(
                      //                             color: wGrey, width: 2)),
                      //                   ),
                      //                   maxLength: 140,
                      //                 ),
                      //               ),
                      //               SizedBox(height: 20),
                      //               MultiSelectFormField(
                      //                 chipBackGroundColor: wPurple,
                      //                 chipLabelStyle: TextStyle(
                      //                     fontWeight: FontWeight.bold,
                      //                     color: white),
                      //                 dialogTextStyle: TextStyle(
                      //                     fontWeight: FontWeight.bold),
                      //                 checkBoxActiveColor: wPrimaryColor,
                      //                 checkBoxCheckColor: white,
                      //                 dialogShapeBorder: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(12.0))),
                      //                 title: Text(
                      //                   "Tags",
                      //                   style: TextStyle(fontSize: 16),
                      //                 ),
                      //                 dataSource: tags!
                      //                     .map((tag) => tag.toJson())
                      //                     .toList()
                      //                     .cast<dynamic>(),
                      //                 textField: 'title',
                      //                 valueField: 'title',
                      //                 okButtonLabel: 'OK',
                      //                 cancelButtonLabel: 'CANCEL',
                      //                 hintWidget: Text('Choose one or more'),
                      //                 initialValue: selectedTags,
                      //                 onSaved: (value) {
                      //                   if (value == null) return;
                      //                   setState(() {
                      //                     selectedTags = selectTags(value);
                      //                   });
                      //                 },
                      //               ),
                      //               SizedBox(height: wDefaultPadding),
                      //               ElevatedButton(
                      //                 style: ElevatedButton.styleFrom(
                      //                   primary: wPrimaryColor,
                      //                 ),
                      //                 onPressed: () {
                      //                   ForumPost post = new ForumPost(
                      //                       creator: user,
                      //                       date: DateTime.now(),
                      //                       title: titleController.text,
                      //                       content: postController.text,
                      //                       likes: 0,
                      //                       tags: selectedTags!,
                      //                       comments: [],
                      //                       subforum: this.widget.forum);
                      //                   post.createPost();
                      //                   setState(() {});
                      //                   // post.content = postController.text;
                      //                   // post.title = titleController.text;
                      //                   // post.creator.userName = user.userName;
                      //                   // posts!.add(post);
                      //                   // _posts.addPost(post);
                      //                   // tourist.addPoints(points);
                      //
                      //                   Navigator.pop(context, true);
                      //                   setState(() {
                      //                     fetchDisplayPosts();
                      //                     fetchTags();
                      //                   });
                      //                 },
                      //                 child: Text('Post'),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ]),
                      //     );
                      //   },
                      // );
                    },
                    backgroundColor: wPrimaryColor,
                    child: SvgPicture.asset(
                      writeIcon,
                      height: 25,
                      color: white,
                    ),
                  ),
                ),
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          expandedHeight: 60,
                          centerTitle: true,
                          title: SvgPicture.asset(
                            wLogo,
                            color: white,
                            height: 25,
                          ),
                          backgroundColor: wPurple,
                          forceElevated: innerBoxIsScrolled,
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildSearch(),
                        SizedBox(height: wDefaultPadding),
                        displayPosts!.length > 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: size.height * 0.7,
                                      width: size.width,
                                      margin:
                                          EdgeInsets.only(top: wDefaultPadding),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 0, 2, 0),
                                        child: ListView.separated(
                                          itemCount: displayPosts!.length,
                                          separatorBuilder: (BuildContext
                                                      context,
                                                  int index) =>
                                              SizedBox(height: wDefaultPadding),
                                          itemBuilder: (context, index) {
                                            final post = displayPosts![index];
                                            return PostCard(
                                              post: post,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Text(
                                  "There are no posts yet!",
                                  style: TextStyle(
                                    color: wJetBlack,
                                    fontSize: 18,
                                    fontFamily: wFont,
                                    fontWeight: wBoldWeight,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchPosts,
        hintText: 'Search posts by title',
      );

  void searchPosts(String query) {
    final result = posts?.where((post) {
      final titleLower = post.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.displayPosts = result;
    });
  }

  /// Takes a flat list of selected tags and adds their respective Tag objects
  List<Tag> selectTags(value) {
    List<String> tagTitles = tags!.map((tag) => tag.getTitle).toList();
    List<Tag> tagsSelected = [];
    print(value);

    for (int i = 0; i < tagTitles.length; i++) {
      for (int j = 0; j < value.length; j++) {
        if (value[j] == tagTitles[i]) {
          tagsSelected.add(tags![i]);
        }
      }
    }
    return tagsSelected;
  }
}
