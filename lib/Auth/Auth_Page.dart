import 'package:flutter/material.dart';
import 'package:todo_list/Screen/LogIn.dart';
import 'package:todo_list/Screen/SignUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool InOrUp = true;
  void to(){
    setState(() {
      InOrUp =!InOrUp;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(InOrUp){
      return LogIn_Screen(to);
    }
    else{
      return SignUp_Screen(to);
    }

  }
}
