import 'package:flutter/material.dart';
import 'package:wijha/models/Forums/Forum.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/screens/forum/subforumScreen.dart';

class SubformCard extends StatefulWidget {
  final Subforum forum;

  const SubformCard({Key? key, required this.forum}) : super(key: key);

  @override
  State<SubformCard> createState() => _SubformCardState();
}

class _SubformCardState extends State<SubformCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => SubformScreen(forum: widget.forum),
          ),
        ),
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          foregroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/discussion-icon-beautiful-meticulously-designed-120778560.jpg'),
                          backgroundColor: wPrimaryColor,
                          radius: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  widget.forum.title,
                                  style: TextStyle(
                                      color: wJetBlack,
                                      fontSize: 18,
                                      fontWeight: wBlackWeight,
                                      letterSpacing: .4),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                widget.forum.content,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.textsms,
                                    color: Colors.grey.withOpacity(0.9),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.forum.totalPosts.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.9)),
                                  ),
                                  Text(
                                    " Posts",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.9)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
