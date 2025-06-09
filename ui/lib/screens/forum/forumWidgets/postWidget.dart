import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wijha/data.dart';
import 'package:wijha/models/Forums/Subforum.dart';
import 'package:wijha/models/Forums/Tag.dart';
import 'package:wijha/models/Forums/tempPosts.dart';
import 'package:wijha/models/Tours/Category.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/models/Forums/ForumPost.dart';
import '../../../models/Users/Guide.dart';

class PostWidget extends StatefulWidget {
  final Size size;

  const PostWidget({
    required this.size,
  });
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int points = ForumPost.travelPoints;
  late ForumPost post;
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  final titleController = TextEditingController();
  final postController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    titleController.dispose();
    postController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
    // post = ForumPost(
    //     creator: Guide(userName: 'Khalid Alamro'),
    //     date: DateTime.now(),
    //     content: "33 This is a very loooooooooooooooooooooooooong post",
    //     title: "Ittihad",
    //     likes: 13,
    //     tags: [Tag(title: 'Discussion', imageUrl: historicalIcon)],
    //     comments: [
    //       {
    //         'name': 'Ahmed Nasser',
    //         'pic': 'https://picsum.photos/300/30',
    //         'message': 'You can check out this place ....'
    //       },
    //       {
    //         'name': 'Mohammed Ahmed',
    //         'pic': 'https://picsum.photos/300/31',
    //         'message': 'You can go to ......'
    //       },
    //     ],
    //     subforum: Subforum(content: "", title: "", imageUrl: "", posts: []));
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      onTap: () => {
        showModalBottomSheet<void>(
          isDismissible: false,
          barrierColor: wJetBlack.withOpacity(0.75),
          backgroundColor: wBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          isScrollControlled: true,
          elevation: 0,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: this.widget.size.longestSide * 0.90,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: wDefaultPadding, horizontal: wDefaultPadding),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              writeIcon,
                              color: wGrey,
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Write a Post",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: wGrey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: wGrey.withOpacity(0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              color: white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(wDefaultPadding),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Post Title',
                          labelStyle: TextStyle(color: wGrey),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: wPrimaryColor, width: 1.5)),
                          focusColor: wPrimaryColor,
                          fillColor: white,
                          filled: true,
                          enabled: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: wGrey, width: 2)),
                        ),
                        maxLength: 25,
                      ),
                      SizedBox(height: wDefaultPadding),
                      Container(
                        height: this.widget.size.longestSide * 0.2,
                        child: TextFormField(
                          controller: postController,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Post Body",
                            labelStyle: TextStyle(color: wGrey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: wPrimaryColor, width: 1.5)),
                            focusColor: wPrimaryColor,
                            fillColor: white,
                            filled: true,
                            enabled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: wGrey, width: 2)),
                          ),
                          maxLength: 140,
                        ),
                      ),
                      SizedBox(height: 20),
                      MultiSelectFormField(
                        chipBackGroundColor: wPurple,
                        chipLabelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        checkBoxActiveColor: wPrimaryColor,
                        checkBoxCheckColor: white,
                        dialogShapeBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        title: Text(
                          "Tags",
                          style: TextStyle(fontSize: 16),
                        ),
                        dataSource: [
                          {
                            "value": "Question",
                          },
                          {
                            "value": "Riyadh",
                          },
                          {
                            "value": "Food",
                          },
                          {
                            "value": "Discussion",
                          },
                          {
                            "value": "Event",
                          },
                        ],
                        textField: 'value',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        hintWidget: Text('Choose one or more'),
                        initialValue: _myActivities,
                        onSaved: (value) {
                          if (value == null) return;
                          setState(() {
                            _myActivities = value;
                          });
                        },
                      ),
                      SizedBox(height: wDefaultPadding),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: wPrimaryColor,
                        ),
                        onPressed: () {
                          post.content = postController.text;
                          post.title = titleController.text;
                          ForumPost newPost = post;
                          // TempPosts().postList.add(newPost);
                          tourist.addPoints(points);
                          Navigator.pop(context, true);
                        },
                        child: Text('Post'),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          },
        ),
      },
    );
  }
}
