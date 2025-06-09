import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/screens/blogs/blogPostScreen.dart';
import 'package:wijha/screens/tour/tourWidgets/tourCtg.dart';
import 'package:wijha/widgets/Tags/blogTag.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class BlogPostCard extends StatefulWidget {
  final BlogPost post;
  const BlogPostCard({
    Key? key,
    required this.context,
    required this.post,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlogPostScreen(blog: this.widget.post)))
      },
      child: Container(
        height: height * 0.40,
        width: width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.post.imageUrl,
                height: height * 0.40,
                width: width * 0.40,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: width * 0.45,
              padding: const EdgeInsets.fromLTRB(10, 10, 2, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                        color: wPurple,
                        fontSize: 18,
                        fontWeight: wBlackWeight,
                        letterSpacing: .4),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 5,
                      children: [
                        for (var tag in widget.post.tags)
                          WTag(
                            tag: tag,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: widget.post.creator.profilePicture.contains("http://") || widget.post.creator.profilePicture.contains("https://")
                              ? NetworkImage(widget.post.creator.profilePicture)
                                  as ImageProvider
                              : AssetImage(widget.post.creator.profilePicture),
                          radius: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Text(widget.post.creator.userName),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(
                              () {
                                isPressed = !isPressed;
                                isPressed
                                    ? widget.post.likes++
                                    : widget.post.likes--;
                              },
                            );
                          },
                          child: Icon(
                            Icons.favorite_sharp,
                            size: 20,
                            color: (isPressed)
                                ? Colors.red
                                : Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          " " + widget.post.likes.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.withOpacity(0.9),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' Likes',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.withOpacity(0.9),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
