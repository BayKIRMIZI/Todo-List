import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Screen/Home_Screen.dart';

import 'Auth_Page.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshat){
          if(snapshat.hasData){
            return Home_Screen();
          }
          else{
            return AuthPage();
          }
        }
      ),
    );
  }
}
