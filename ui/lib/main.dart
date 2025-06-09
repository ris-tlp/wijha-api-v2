import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/widgets/constants.dart';
import 'package:wijha/screens/signUpIn/signUpIn.dart';

void main() {
  runApp(ProviderScope(child: Wijha()));
}

class Wijha extends ConsumerStatefulWidget {
  MainPage createState() => MainPage();
}

class MainPage extends ConsumerState<Wijha> {
// the home page index in the bottomNav
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wijha',
      theme: ThemeData(
        scaffoldBackgroundColor: wBackgroundColor,
        primaryColor: wPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: wJetBlack),
      ),
      home: Builder(builder: (context) {
        double width = MediaQuery.of(context).size.width;
        return SafeArea(
          child: Scaffold(
            body: SignUpIn(),
          ),
        );
      }),
    );
  }
}
