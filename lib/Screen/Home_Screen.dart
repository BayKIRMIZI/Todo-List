import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_list/Colors/Colors.dart';
import 'package:todo_list/Screen/Add_Note_Screen.dart';
import 'package:todo_list/Widgets/Task_Widgets.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  bool show = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Add_Screen(),
            ));
          },
          backgroundColor: custom_gren,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Task_Widget();
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
