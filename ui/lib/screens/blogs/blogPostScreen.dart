import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/widgets/constants.dart';

class BlogPostScreen extends StatefulWidget {
  final BlogPost blog;

  const BlogPostScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  _BlogPostScreen createState() => _BlogPostScreen();
}

class _BlogPostScreen extends State<BlogPostScreen> {
  bool isPressed = false;

  String _date() {
    return widget.blog.date.day.toString() +
        ('/') +
        widget.blog.date.month.toString() +
        ('/') +
        widget.blog.date.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          backgroundColor: wPurple,
          title: SvgPicture.asset(
            wLogo,
            color: white,
            height: 25,
          ),
        ),
        extendBody: true,
        backgroundColor: wBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: wDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: wDefaultPadding),
                      child: WTitle(title: widget.blog.title),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: widget.blog.creator.profilePicture.contains("http://") || widget.blog.creator.profilePicture.contains("https://")
                              ? NetworkImage(widget.blog.creator.profilePicture)
                                  as ImageProvider
                              : AssetImage(widget.blog.creator.profilePicture),
                          radius: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                widget.blog.creator.userName,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: wBoldWeight,
                                    color: wPurple),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Level " + (widget.blog.creator.getLevel()),
                                style: TextStyle(color: wMagenta, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(_date()),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  widget.blog.imageUrl,
                  height: size.height * .4,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: wDefaultPadding),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(
                          () {
                            isPressed = !isPressed;
                            isPressed
                                ? widget.blog.likes++
                                : widget.blog.likes--;
                          },
                        );
                      },
                      child: Icon(
                        Icons.favorite_sharp,
                        size: 30,
                        color: (isPressed)
                            ? Colors.red
                            : Colors.grey.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      "  " + widget.blog.likes.toString(),
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
              Padding(
                padding: const EdgeInsets.all(wDefaultPadding),
                child: Container(
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.blog.body,
                          style: TextStyle(
                              color: wJetBlack,
                              fontFamily: wFont,
                              fontSize: 16),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
