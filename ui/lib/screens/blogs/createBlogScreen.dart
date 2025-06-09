import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:wijha/models/Blogs/BlogPost.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/authProvider.dart';
import 'package:wijha/providers/blogProvider.dart';

import '../../models/Forums/Tag.dart';
import '../../models/Tours/Tour.dart';
import '../../widgets/constants.dart';
import '../../widgets/loading.dart';

class BlogCreationScreen extends ConsumerStatefulWidget {
  const BlogCreationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogCreationScreen> createState() => _BlogCreationScreenState();
}

class _BlogCreationScreenState extends ConsumerState<BlogCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String body = '';
  List<Tag>? tags;
  List<Tag>? selectedTags;
  Future<List<Tag>>? futureTags;
  String image = '';

  bool loading = true;

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
    return Consumer(builder: (context, ref, _) {
      final _auth = ref.watch(userProvider.notifier);
      final _posts = ref.watch(blogProvider.notifier);

      User user = _auth.getUser();

      Size size = MediaQuery.of(context).size;

      /// Only load page if tags and posts have been fetched successfully
      if (tags != null) {
        loading = false;
      }

      return loading
          ? Loading()
          : SafeArea(
              child: Scaffold(
                appBar: logoAppBar,
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: wDefaultPadding),
                  height: size.height,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: wDefaultPadding,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: _getImageFromGallery,
                            child: image == ''
                                ? Container(
                                    height: 220,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: wGrey,
                                            width: 1.25,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Icon(
                                      Icons.add,
                                      color: wGrey,
                                      size: 75,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          SizedBox(height: wDefaultPadding),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Post Title',
                              labelStyle: TextStyle(color: wGrey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: wPrimaryColor, width: 1.5)),
                              focusColor: wPrimaryColor,
                              fillColor: white,
                              filled: true,
                              enabled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: wGrey, width: 2)),
                            ),
                            maxLength: 25,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Enter a title for your post';
                              return null;
                            },
                            onChanged: (newValue) => title = newValue,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Content',
                              labelStyle: TextStyle(color: wGrey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: wPrimaryColor, width: 1.5)),
                              focusColor: wPrimaryColor,
                              fillColor: white,
                              filled: true,
                              enabled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: wGrey, width: 2)),
                            ),
                            minLines: 7,
                            maxLines: 10,
                            maxLength: 5000,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Enter a body for your post';
                              return null;
                            },
                            onChanged: (newValue) => body = newValue,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MultiSelectFormField(
                            chipBackGroundColor: wPurple,
                            chipLabelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: white),
                            dialogTextStyle:
                                TextStyle(fontWeight: FontWeight.bold),
                            checkBoxActiveColor: wPrimaryColor,
                            checkBoxCheckColor: white,
                            dialogShapeBorder: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            title: Text(
                              "Tags",
                              style: TextStyle(fontSize: 16),
                            ),
                            dataSource: tags!
                                .map((tag) => tag.toJson())
                                .toList()
                                .cast<dynamic>(),
                            textField: 'title',
                            valueField: 'title',
                            okButtonLabel: 'OK',
                            cancelButtonLabel: 'CANCEL',
                            hintWidget: Text('Choose one or more'),
                            initialValue: selectedTags,
                            onSaved: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedTags = selectTags(value);
                              });
                            },
                          ),
                          SizedBox(
                            height: wDefaultPadding,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlogPost blogPost = new BlogPost(
                                    title: title,
                                    body: body,
                                    imageUrl: image,
                                    tags: selectedTags!,
                                    date: DateTime.now(),
                                    likes: 0,
                                    creator: user);

                                // blogPost.createBlogPost();
                                _posts.addPost(blogPost);

                                Navigator.pop(context, true);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: size.width * .8,
                              decoration: BoxDecoration(
                                  color: wMagenta,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        color: wGrey,
                                        blurRadius: 1.5)
                                  ]),
                              child: Text(
                                'Create Post',
                                style: TextStyle(
                                  color: white,
                                  fontFamily: wFont,
                                  fontWeight: wBoldWeight,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: wDefaultPadding,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }

  _getImageFromGallery() async {
    // Picks an image from the user's gallery
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // final File? image_file = File(image!.path);
    if (image != null) {
      // Upload image to bucket and get the corresponding URL

      String imageUrl = await BlogPost.uploadImageBucket(image);
      this.image = imageUrl;
    }

    // for (int i = 0; i < images.length; i++) {
    //   this.images!.add(File(images[i].path).path);
    //   this.assetImage.add(true);
    // }
    // print('Images: ' + this.images.toString());
    // Refresh the step for image display
    onStepRefresh();
  }

  void onStepRefresh() {
    setState(() {});
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
