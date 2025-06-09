import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wijha/blogsData.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/screens/blogs/blogpostcard.dart';
import 'package:wijha/widgets/Cards/Destination/DestinationCardList.dart';
import 'package:wijha/widgets/Tags/blogTag.dart';
import 'package:wijha/widgets/blogSearch.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/widgets/loading.dart';
import 'package:wijha/widgets/searchWidget.dart';
import '../../models/Blogs/BlogPost.dart';

class BlogSearchScreen extends StatefulWidget {
  @override
  State<BlogSearchScreen> createState() => _BlogSearchScreenState();
}

class _BlogSearchScreenState extends State<BlogSearchScreen> {
  List<BlogPost>? displayPosts;
  bool loading = true;
  String query = '';
  int counter =
      0; // counter is used to initiate the state of displayTours. Without counter, displayTours will constantly update not allowing sorting
  Future<List<BlogPost>>? futureBlogPosts;
  List<BlogPost>? posts;

  var textStyle =
      TextStyle(fontFamily: wFont, fontWeight: wBoldWeight, fontSize: 14);
  @override
  void initState() {
    super.initState();
    futureBlogPosts = BlogPost.getAllBlogPosts();
    futureBlogPosts!.then((data) => setState(() {
          posts = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (posts != null) {
      if (counter == 0) {
        displayPosts = posts;
        counter = 1;
        loading = false;
      }
    }
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
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
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildSearch(),
                    Expanded(
                      child: posts!.length > 0
                          ? ListView.builder(
                              itemCount: displayPosts!.length,
                              itemBuilder: (context, index) {
                                final post = displayPosts![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: wDefaultPadding,
                                      vertical: 10),
                                  child: BlogPostCard(
                                    context: context,
                                    post: post,
                                  ),
                                );
                              },
                            )
                          : Center(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchPosts,
        hintText: 'Search tours by title',
      );

  void searchPosts(String query) {
    final posts = this.posts!.where((post) {
      final titleLower = post.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.displayPosts = posts;
    });
  }
}
