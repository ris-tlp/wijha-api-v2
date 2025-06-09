import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wijha/introScreen.dart';
import 'package:wijha/models/Users/User.dart';
import 'package:wijha/providers/provinceProvider.dart';
import 'package:wijha/screens/home/homeMain.dart';
import 'package:wijha/widgets/loading.dart';
import '../../providers/authProvider.dart';
import '../../widgets/constants.dart';
import '../home/homeScreen.dart';

class SignUpIn extends ConsumerStatefulWidget {

  const SignUpIn({Key? key}) : super (key: key);

  @override
  ConsumerState<SignUpIn> createState() => _SignUpIn();
}

class _SignUpIn extends ConsumerState<SignUpIn> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  //  GlobalKey is used to validate the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  //  TextEditingController to get the data from the TextFields
  //  we can also use Riverpod to manage the state of the TextFields
  //  but again I am not using it here
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff192028),
      body: Consumer(builder: (context, ref, _) {
        final _auth = ref.watch(userProvider.notifier);
        final init = ref.watch(provinceProvider.notifier).isInit();
        Future<void> _login() async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          bool result = await _auth.signInWithUserNameAndPassword(userName: _username.text, password: _password.text);

          if (result) {
            navigate(init);
          }

          // print(_email.text); // This are your best friend for debugging things
          //  not to mention the debugging tools
          // print(_password.text);
        }
        return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/RiyadhMain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * (animation2.value + .58),
                    left: size.width * .21,
                    child: CustomPaint(
                      painter: MyPainter(50),
                    ),
                  ),
                  Positioned(
                    top: size.height * .98,
                    left: size.width * .1,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value - 30),
                    ),
                  ),
                  Positioned(
                    top: size.height * .5,
                    left: size.width * (animation2.value + .8),
                    child: CustomPaint(
                      painter: MyPainter(30),
                    ),
                  ),
                  Positioned(
                    top: size.height * animation3.value,
                    left: size.width * (animation1.value + .1),
                    child: CustomPaint(
                      painter: MyPainter(60),
                    ),
                  ),
                  Positioned(
                    top: size.height * .1,
                    left: size.width * .8,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * .1),
                          child: SvgPicture.asset(
                            'assets/logos/sus_logo.svg',
                            color: Color(0xFFE5E5E5),
                            height: 60,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              component1(Icons.account_circle_outlined,
                                  'User name...', _username, false, false),
                              component1(
                                  Icons.lock_outline, 'Password...', _password,
                                  true, false),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  component2(
                                    'LOGIN',
                                    2.58,
                                        () {
                                      HomeScreen();
                                      HapticFeedback.lightImpact();

                                      //User user = User(userName: )

                                      _login();
                                    },
                                  ),
                                  SizedBox(width: size.width / 20),
                                  component2(
                                    'Forgot password?',
                                    2.58,
                                        () {
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                          msg: 'Think Harder!');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            component3(
                              'Create a new Account',
                              2,
                                  () {
                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                    msg: 'Navigate to Create new Account Screen');
                              },
                            ),
                            SizedBox(height: size.height * .02),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: wDefaultPadding),
                              child: component4(
                                'Continue as guest',
                                2,
                                    () {
                                  navigate(init);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, TextEditingController _controller, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: _controller,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            validator: (value) {
              if (value!.isEmpty)
              return null;
            },
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component3(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.50),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(
                color: wJetBlack.withOpacity(.8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component4(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(
                color: Colors.white.withOpacity(.8),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigate(bool init) {

    if (!init)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => IntroScreen(),
        ),
      );
    else
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeMain(),
        ),
      );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = wGradient.createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
