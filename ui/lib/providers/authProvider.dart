import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Users/Guide.dart';
import 'package:wijha/models/Users/Tourist.dart';
import '../data.dart';
import '../models/Users/User.dart';
import '../models/authModel.dart';

//  This is how you create a provider in Riverpod. Note the syntax may change in near future.
//  This is a provider which provides all the features of Authentication class we have created

//  The syntax is pretty simple.
//  you are using a Class Provider and specifying the type of provider.
//  now this takes a function takes a providerreference ref as a parameter
//  this ref can you used to access a provider within a provider.
//  if you are not using a provider within a provdier, no worries. It's not compulosry.
//  you can use a provider without a provider.

class AuthenticationProvider extends StateNotifier<User> {
  AuthenticationProvider() : super(user);

  signInWithUserNameAndPassword(
      {required String userName, required String password}) async {
    var response = await User.loginUser(userName, password);

    // If the password and username did not match any records
    if (response == null) {
      return false;
    }
    // User matches a tourist account
    else if (response[1] == 1) {
      Tourist tourist = response[0];
      state = tourist;
      return true;
    }
    // User matches a guide account
    else {
      Guide guide = response[0];
      state = guide;
      return true;
    }

    // if (userName.toLowerCase() == 'tourist') {
    //   state = loginTourist;
    //   return true;
    // } else if (userName.toLowerCase() == 'guide') {
    //   state = loginGuide;
    //   return true;
    // } else if (userName.toLowerCase() == 'guide_1') {
    //   state = guide;
    //   return true;
    // } else if (userName.toLowerCase() == 'guide_2') {
    //   state = guide2;
    //   return true;
    // }
    // return false;
  }

  createUserWithUserNameAndPassword(
      {required String userName, required String password}) {
    /// To be implemented
    return false;
  }

  getUser() {
    return state;
  }

  void signOut() {
    state = User(userName: 'Uninitialized');
  }
}

final userProvider = StateNotifierProvider<AuthenticationProvider, User>(
    (ref) => AuthenticationProvider());


//  Here I have shared the example of a provider used within a provider.
// keep in mind I am reading a provider from a provider not watching it.
//  The docs mention not to use watch in a provider. This is bad for performance
//  if the data changes continuously your app will suck bad

// final authStateProvider = StreamProvider<User?>((ref) {
//   return ref.read(authenticationProvider).authStateChange;
// });

//  There are different Types of Provider
//  Provider<T> is the most basic type of provider
//  FutureProvider<T> which involves a Future
//  StreamProvider<T> which involves a Stream
//  and many more. Refer to their docs for more info