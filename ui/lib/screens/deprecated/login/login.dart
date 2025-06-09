import 'package:flutter/material.dart';
import 'package:wijha/widgets/constants.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 400,
            width: size.width * 0.85,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: wDefaultPadding),
                  child: Text(
                    'Welcome back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: wJetBlack,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: wFont,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: wDefaultPadding,
                      horizontal: wDefaultPadding + 30),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email Address",
                        isDense: true,
                        prefixIcon: Icon(Icons.mail, color: wPrimaryColor),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: wDefaultPadding,
                      horizontal: wDefaultPadding + 30),
                  child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        isDense: true,
                        prefixIcon: Icon(Icons.lock, color: wPrimaryColor),
                      )),
                ),
                Container(
                  width: 150,
                  height: 45,
                  padding: EdgeInsets.symmetric(vertical: wDefaultPadding - 10),
                  decoration: const BoxDecoration(
                      color: wPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: wFont,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(wDefaultPadding),
                  child: Text(
                    'Dont have an account? Sign up now!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontFamily: wFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container();
}
