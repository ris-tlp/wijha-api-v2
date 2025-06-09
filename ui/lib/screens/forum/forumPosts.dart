import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/widgets/constants.dart';
import 'forumComment.dart';

class ForumPosts extends StatefulWidget {
  final ForumPost post;
  const ForumPosts(this.post);
  @override
  _ForumPosts createState() => _ForumPosts();
}

class _ForumPosts extends State<ForumPosts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Center(
                                    child: CircleAvatar(
                                      foregroundImage: NetworkImage(
                                          widget.post.creator.profilePicture),
                                      backgroundColor: wPrimaryColor,
                                      radius: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: size.width * 0.65,
                                          child: Text(
                                            widget.post.title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: .4),
                                          ),
                                        ),
                                        SizedBox(height: 2.0),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              widget.post.creator.userName,
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              widget.post.date.day.toString(),
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                            Text(
                                              '-',
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                            Text(
                                              widget.post.date.month.toString(),
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                            Text(
                                              '-',
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                            Text(
                                              widget.post.date.year.toString(),
                                              style:
                                                  TextStyle(color: wJetBlack),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(wDefaultPadding),
                          child: Text(
                            widget.post.content,
                            style: TextStyle(
                                color: wJetBlack,
                                fontSize: 16,
                                letterSpacing: .3),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.fromLTRB(1, 0, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          widget.post.isPressed =
                                              !widget.post.isPressed;
                                          if (widget.post.isPressed) {
                                            widget.post.likes++;
                                            widget.post.creator.addPoints(
                                                ForumPost.travelPoints);
                                          } else {
                                            widget.post.likes--;
                                          }
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.thumb_up, size: 22),
                                    color: (widget.post.isPressed)
                                        ? Colors.blue
                                        : Colors.grey.withOpacity(0.9),
                                  ),
                                  Text(
                                    widget.post.likes.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.9),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    " Votes",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.9),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.textsms,
                                    color: Colors.grey.withOpacity(0.9),
                                    size: 16,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    widget.post.comments.length.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.9),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    " Replies",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.9),
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: wGradient,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => ForumComment(widget.post),
                              ),
                            ),
                          },
                          child: const Text('View All comments'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
