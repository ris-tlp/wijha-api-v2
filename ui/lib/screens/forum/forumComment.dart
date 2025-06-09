import 'dart:developer';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/screens/signUpIn/signUpIn.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/widgets/loading.dart';

class ForumComment extends ConsumerStatefulWidget {
  final ForumPost post;
  const ForumComment(this.post);

  @override
  ConsumerState<ForumComment> createState() => _ForumCommentState();
}

class _ForumCommentState extends ConsumerState<ForumComment> {
  final formKey = GlobalKey<FormState>();
  bool loading = true;
  List<ForumPost>? comments;
  Future<List<ForumPost>>? futureComments;

  @override
  void initState() {
    futureComments = this.widget.post.getAllCommentsOfPost();
    futureComments!.then((data) => setState(() {
          comments = data;
        }));
    super.initState();
  }

  final TextEditingController commentController = TextEditingController();

  /// replace with data fetched
  List fileData = [
    {
      'name': 'Ahmed Nasser',
      'pic': 'https://picsum.photos/300/30',
      'message': 'You can check out this place ....'
    },
    {
      'name': 'Mohammed Ahmed',
      'pic': 'https://picsum.photos/300/31',
      'message': 'You can go to ......'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(data[i].creator.profilePicture + "$i")),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  data[i].creator.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                data[i].content,
                style: TextStyle(color: wJetBlack, fontSize: 16),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      if (comments != null) {
        loading = false;
        inspect(comments);
      }

      final _auth = ref.watch(userProvider.notifier);
      User user = _auth.getUser();
      return loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: SvgPicture.asset(
                  wLogo,
                  color: white,
                  height: 25,
                ),
                backgroundColor: wPurple,
              ),
              body: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: CommentBox(
                  userImage: user.profilePicture,
                  child: commentChild(comments),
                  labelText: 'Write a comment...',
                  withBorder: false,
                  errorText: 'Comment cannot be blank',
                  sendButtonMethod: () {
                    if (formKey.currentState != "" &&
                        commentController.text != "" &&
                        user.type != "guest") {
                      print(commentController.text);
                      setState(() {
                        /// Create a comment through ForumPost model
                        ForumPost comment = ForumPost(
                            creator: user,
                            date: DateTime.now(),
                            subforum: this.widget.post.subforum,
                            title: "",
                            content: commentController.text,
                            likes: 0,
                            tags: [],
                            comments: []);

                        comment.createComment(this.widget.post);
                      });

                      commentController.clear();
                      FocusScope.of(context).unfocus();
                    } else {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignUpIn()));
                    }
                  },
                  formKey: formKey,
                  commentController: commentController,
                  backgroundColor: Colors.white,
                  textColor: Colors.grey,
                  sendWidget:
                      Icon(Icons.send_sharp, size: 30, color: Colors.grey),
                ),
              ),
            );
    });
  }
}
