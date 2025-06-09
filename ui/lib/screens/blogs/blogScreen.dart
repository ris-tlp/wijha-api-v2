import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/blogsData.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/blogProvider.dart';
import 'package:wijha/screens/blogs/blogPostScreen.dart';
import 'package:wijha/screens/blogs/createBlogScreen.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationCardList.dart';
import 'package:wijha/widgets/Tags/blogTag.dart';
import 'package:wijha/widgets/blogSearch.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';

import '../../models/Blogs/BlogPost.dart';
import '../../widgets/searchWidget.dart';
import 'blogpostcard.dart';

class BlogScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends ConsumerState<BlogScreen> {
  List<BlogPost>? newPosts;
  List<BlogPost>? popPosts;

  bool init = true;
  bool loading = true;
  String query = '';
  List<BlogPost>? displayPosts;
  List<BlogPost>? blogPosts;
  Future<List<BlogPost>>? futureBlogPosts;

  var textStyle =
      TextStyle(fontFamily: wFont, fontWeight: wBoldWeight, fontSize: 14);
  @override
  void initState() {
    // futureBlogPosts = BlogPost.getAllBlogPosts();
    // futureBlogPosts!.then((data) => setState(() {
    //       blogPosts = data;
    //     }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, _) {
        final _auth = ref.watch(userProvider.notifier);
        final _posts = ref.watch(blogProvider.notifier);

        if (init) {
          _posts.initPosts();
          init = !init;
        }

        blogPosts = _posts.getPosts();
        displayPosts = newPosts;

        /// Render only if both items have been fetched
        if (blogPosts != null) {
          newPosts = blogPosts!.toList()..sort((a, b) => b.date.compareTo(a.date));
          popPosts = blogPosts!.toList()
            ..sort((a, b) => b.likes.compareTo(a.likes));
          loading = false;
        }

        return loading
            ? Loading()
            : DefaultTabController(
              length: 2,
              child: Scaffold(
              floatingActionButton: Visibility(
                visible: _auth.getUser() is Guide ? true : false,
                child: FloatingActionButton(
                  onPressed: () => {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => BlogCreationScreen()))
                  },
                  backgroundColor: wPrimaryColor,
                  child: Icon(
                   Icons.add,
                   size: 40,
                  ),
                ),
              ),
          body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildSearch(),
                    Row(
                      children: [
                        Container(
                          height: size.height * .3,
                          width: size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: popPosts!.length,
                            itemBuilder: (context, index) {
                              final post = popPosts![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: BlogHeaderCard(post: post),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: wDefaultPadding),
                    tabsNav(textStyle, size.width),
                    Row(
                      children: [
                        Container(
                          height: size.height * .4,
                          padding:
                          EdgeInsets.symmetric(horizontal: wDefaultPadding),
                          width: size.width,
                          child: TabBarView(
                            children: [
                              newTab(),
                              popularTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          )
      ),
            );
    });
  }

  Widget buildSearch() => BlogSearchBar(
        text: query,
        // onChanged: searchPosts
        onChanged: (query) => {},
        hintText: 'Search posts by title',
      );
  //
  // void searchPosts(String query) {
  //   final result = posts?.where((post) {
  //     final titleLower = post.title.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //
  //     return titleLower.contains(searchLower);
  //   }).toList();
  //
  //   setState(() {
  //     this.query = query;
  //     this.displayPosts = result;
  //   });
  // }

  Container tabsNav(
    TextStyle textStyle,
    double width,
  ) {
    return Container(
      height: 40,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: wDefaultPadding),
      child: TabBar(
        tabs: [
          Tab(
            child: Text(
              'New',
              style: textStyle,
            ),
          ),
          Tab(
            child: Text(
              'Popular',
              style: textStyle,
            ),
          ),
        ],
        labelColor: wPrimaryColor,
        indicatorColor: wPrimaryColor,
        indicatorWeight: 3,
        unselectedLabelColor: wGrey,
        automaticIndicatorColorAdjustment: true,
      ),
    );
  }

  newTab() {
    return ListView.builder(
      itemCount: newPosts?.length,
      itemBuilder: (context, index) {
        final post = newPosts![index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: BlogPostCard(
            context: context,
            post: post,
          ),
        );
      },
    );
  }

  popularTab() {
    return ListView.builder(
      itemCount: popPosts?.length,
      itemBuilder: (context, index) {
        final post = popPosts![index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: BlogPostCard(
            context: context,
            post: post,
          ),
        );
      },
    );
  }
}

class BlogHeaderCard extends StatelessWidget {
  final BlogPost post;
  const BlogHeaderCard({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlogPostScreen(blog: this.post)))
      },
      child: Stack(
        children: [
          Container(
            height: size.height * .3,
            width: size.width * .9,
            decoration: BoxDecoration(
              color: wPrimaryColor,
              image: DecorationImage(
                  image: NetworkImage(post.imageUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            height: size.height * .3,
            width: size.width * .9,
            decoration: BoxDecoration(
              gradient: wPictureTint,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            bottom: 10,
            left: wDefaultPadding,
            child: Container(
              width: size.width * .85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                        color: white,
                        fontFamily: wFont,
                        fontWeight: wBlackWeight,
                        fontSize: 24),
                  ),
                  Row(
                    children: [],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: post.creator.profilePicture.contains("http://") || post.creator.profilePicture.contains("https://")
                            ? NetworkImage(post.creator.profilePicture)
                                as ImageProvider
                            : AssetImage(post.creator.profilePicture),
                        backgroundColor: wPrimaryColor,
                        radius: 10,
                      ),
                      SizedBox(width: 5),
                      Text(
                        post.creator.userName,
                        style: TextStyle(
                            color: white, fontFamily: wFont, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
