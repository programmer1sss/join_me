import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join_me/domain/user.dart';
import 'package:join_me/main.dart';
import 'package:join_me/screens/auth/auth_page.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser? user = Provider.of<AuthUser?>(context) ;
    final bool isLoggedIn = user != null;
    return isLoggedIn ? MyHomePage() : AuthorizationPage();
  }
}
