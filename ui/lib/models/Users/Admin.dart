import 'package:wijha/models/Tours/Tour.dart';

class Admin{
  int id;
  String userName;
  String password;
  int rating;
  final int type = 3;

  Admin(
      this.id,
      this.userName,
      this.password,
      this.rating,
      );

  final List<Tour> tourList = [

  ];
}