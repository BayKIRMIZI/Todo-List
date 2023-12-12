import 'package:flutter/material.dart';
import 'package:todo_list/Colors/Colors.dart';
import 'package:todo_list/Strings/Hint_Texts.dart';
import 'package:todo_list/Strings/String_Texts.dart';


class SignUp_Screen extends StatefulWidget {

  final VoidCallback show;

  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _LogIn_ScreenState();
}

class _LogIn_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  @override
  void initState() {

    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });

    _focusNode2.addListener(() {
      setState(() {});
    });

    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              image(),
              const SizedBox(height: 50),
              textfield(email, _focusNode1, email_hint, Icons.email),
              const SizedBox(height: 10),
              textfield(password, _focusNode2, password_hint, Icons.password),
              const SizedBox(height: 10),
              textfield(passwordConfirm, _focusNode3, passwordConfirm_hint, Icons.password),
              const SizedBox(height: 8),
              account(),
              const SizedBox(height: 20),
              SignUp_Bottom(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Padding image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/7.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      String typeName, IconData icons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icons,
              color:
              _focusNode.hasFocus ? custom_gren : const Color(0xffc5c5c5),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_gren,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            have_account_text,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              logIn_text,
              style: const TextStyle(
                  color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget SignUp_Bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: custom_gren,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(signUp_text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
