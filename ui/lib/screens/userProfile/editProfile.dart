import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wijha/widgets/constants.dart';

import '../../models/Users/User.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({
    required this.user,
  });
  @override
  _EditProfilePageScreen createState() => _EditProfilePageScreen();
}

class _EditProfilePageScreen extends State<EditProfileScreen> {
  // String currentPassword = ; Why are we getting their password lmao
  bool showPassword = false;
  bool passField = true;
  bool selected = true;
  bool toggle = true;
  var _image;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: wPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontSize: 20, fontFamily: wFont),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      // color: wGrey,
                      child: _image == null
                          ? Center(
                      )
                          : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          )),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.user.profilePicture.contains('http://') || widget.user.profilePicture.contains('https://') ? NetworkImage(widget.user.profilePicture) as ImageProvider : AssetImage(widget.user.profilePicture))),

                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: wPrimaryColor,
                          ),
                            child: IconButton(
                              onPressed: _getImageFromGallery,
                              icon: Icon(
                                Icons.edit,
                                color: white,
                                // ),
                              ),
                            ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: wPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Personal Info",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: wFont),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),
              buildTextField("Name", widget.user.userName, false),
              buildTextField("E-mail", "opkswe418@wijha.com", false),
              buildTextField("Phone", "05XXXXXXXX", false),
              buildTextField("Location", widget.user.location, false),
              buildAccountOptionRow(context, "Change password?"),

              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Icon(
                    Icons.volume_up_outlined,
                    color: wPrimaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: wFont),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              buildNotificationOptionRow("Popular Tours Near You", toggle),
              buildNotificationOptionRow("Account Activity", toggle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    // padding: EdgeInsets.symmetric(horizontal: 50),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // widget.user.update()
                    },
                    // color: wPrimaryColor,
                    // padding: EdgeInsets.symmetric(horizontal: 50),
                    // elevation: 2,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    // icon: Icon(Icons.save),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: wPrimaryColor
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                      // Icon(Icons.save),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        cursorColor: wPrimaryColor,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                  selected = !selected;
                });
              },
              icon: Icon( selected ? Icons.visibility : Icons.visibility_off, color: wPrimaryColor,),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
                fontFamily: wFont
            )),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              fontFamily: wFont),
        ),
        Transform.scale(
            scale: 0.8,
            // child: CupertinoSwitch(
            //   activeColor: wPrimaryColor,
            //   value: isActive,
            //   onChanged: (bool val) {},
            // )
        child: InkWell(
              child: CupertinoSwitch(
              trackColor: wJetBlack, // **INACTIVE STATE COLOR**
              activeColor: wPrimaryColor, // **ACTIVE STATE COLOR**
              value: isActive,
              onChanged: (bool value) {
                setState(() {
                  isActive = !value;
                  },
                );
                },
              ),
               onTap: () { setState(() { isActive = !isActive; });},
              ),
        ),
      ],
    );
  }
  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                    key: _formkey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0,left: 10,right: 10),
                            child: Text(
                              "Current Password",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: wGrey,
                                  fontFamily: wFont),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       currentPassword,
                      //       style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500,
                      //           color: wGrey,
                      //           fontFamily: wFont),
                      //     ),
                      //   ],
                      // ),
                      TextFormField(
                          controller: password,
                          keyboardType: TextInputType.text,
                        obscureText: passField ? showPassword : false,
                        decoration: InputDecoration(
                          suffixIcon: true
                              ?
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                                selected = !selected;
                              });
                            },
                            icon: Icon( selected ? Icons.visibility : Icons.visibility_off, color: wPrimaryColor,),
                          )
                              : null,
                          labelText: 'New Password',
                          labelStyle: TextStyle(color: wGrey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                          focusColor: wPrimaryColor,
                          fillColor: white,
                          filled: true,
                          enabled: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: wGrey, width: 2)),
                        ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            }
                          },
                          // onSaved: (newValue) => user.setPassword = newValue!
                        ),

                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: confirmpassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration:InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: wGrey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: wPrimaryColor, width: 1.5)),
                            focusColor: wPrimaryColor,
                            fillColor: white,
                            filled: true,
                            enabled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: wGrey, width: 2)),
                          ),
                        validator: (value){
                            // validateTextField(value);
                            print(password.text);
                            print(confirmpassword.text);
                            if(password.text != confirmpassword.text){
                              String txt = "Password does not match";
                              return txt;
                            }
                            SizedBox(
                              child: Text("Password does not match"),
                            );
                            return null;
                          },
                          // onSaved: (newValue) => user.setPassword = newValue!

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: RaisedButton(
                          color: wPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Colors.blue,width: 2)
                          ),
                          textColor:Colors.white,
                          onPressed: () {
                            if(_formkey.currentState!.validate())
                              {
                                print("successful");
                                // currentPassword = confirmpassword.text;
                                Navigator.of(context).pop();
                                return;
                              }
                            else
                              {
                            print("Failed");
                              }
                            },

                          child: Text("Submit"),

                        ),
                      ),],
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel", style: TextStyle(color: Colors.red),)),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: wPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateTextField(value) {
    // Validator for text fields
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
  }
  _getImageFromGallery() async {
    // Picks an image from the user's gallery
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    // final File? image_file = File(image!.path);
    _image = image;

    // Refresh the step for image display
    onStepRefresh();
  }
  onStepRefresh() {
    // Refreshes the step so that an image uploaded is displayed immediately
    // setState(() => activeStep = activeStep);
    setState(() {});
  }

}