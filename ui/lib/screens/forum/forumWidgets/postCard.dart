import 'package:flutter/material.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/screens/forum/forumPosts.dart';
import 'package:wijha/widgets/Tags/whiteTag.dart';
import 'package:wijha/widgets/constants.dart';

class PostCard extends StatefulWidget {
  final ForumPost post;
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final List<Tag> ctgList = this.widget.post.tags;
    CircleAvatar avatar = CircleAvatar(
      foregroundImage:
          NetworkImage(widget.post.creator.profilePicture),
      backgroundColor: wPrimaryColor,
      radius: 22,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => ForumPosts(widget.post),
              ),
            ),
            child: Container(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: widget.post.title,
                          style: TextStyle(
                              color: wPurple,
                              fontSize: 18,
                              fontWeight: wBlackWeight,
                              letterSpacing: .4),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: avatar,
                          height: 35,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.creator.userName,
                              style: TextStyle(
                                  color: wJetBlack, fontWeight: wBoldWeight),
                            ),
                            Text(
                              "Level " + widget.post.creator.getLevel(),
                              style: TextStyle(color: wJetBlack),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 15),
                              Text(
                                widget.post.date.day.toString(),
                                style: TextStyle(color: wJetBlack),
                              ),
                              Text(
                                '-',
                                style: TextStyle(color: wJetBlack),
                              ),
                              Text(
                                widget.post.date.month.toString(),
                                style: TextStyle(color: wJetBlack),
                              ),
                              Text(
                                '-',
                                style: TextStyle(color: wJetBlack),
                              ),
                              Text(
                                widget.post.date.year.toString(),
                                style: TextStyle(color: wJetBlack),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              width: width,
              child: ctgSlider(ctgList),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => ForumPosts(widget.post),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 60,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    text: widget.post.content,
                    style: TextStyle(
                        color: wJetBlack, fontSize: 16, letterSpacing: .3),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          widget.post.isPressed = !widget.post.isPressed;
                          if (widget.post.isPressed) {
                            widget.post.likes++;
                            widget.post.creator
                                .addPoints(ForumPost.travelPoints);
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
                    ' Votes',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.withOpacity(0.9),
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => ForumPosts(widget.post),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
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
                        ' Replies',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.withOpacity(0.9),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container ctgSlider(List<Tag> ctgList) {
    return Container(
      padding: EdgeInsets.symmetric(
            vertical: 10,
          ) +
          EdgeInsets.only(
            left: 10,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: wGradient,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          for (var i = 0; i < ctgList.length; i++) ...[
            WhiteTag(tag: ctgList[i]),
          ],
        ]),
      ),
    );
  }
}
