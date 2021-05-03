import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './services/AuthService.dart';
import 'package:provider/provider.dart';
import './UI/screens/HomeScreen.dart';
import './UI/screens/SignInScreen.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final userIsLoggedIn = context.watch<User>();
    // print(userIsLoggedIn);
    // if (userIsLoggedIn != null) {
    //   return HomeScreen();
    // }
    return HomeScreen();
    // return SignInScreen();
  }
}
