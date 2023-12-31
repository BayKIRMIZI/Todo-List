import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_list/Colors/Colors.dart';
import 'package:todo_list/Data/FireStore.dart';
import 'package:todo_list/Strings/String_Texts.dart';
import 'package:todo_list/Widgets/Note_Widget.dart';

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
      appBar: AppBar(
        backgroundColor: customBackgroundColor,
        title: Center(
            child: Text(
          appBar_text,
          style: TextStyle(color: Colors.white),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            UpdateController();
            getDialog(newTask_Title);
          },
          backgroundColor: customBackgroundColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FireStore_DataSource().stream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final notesList = FireStore_DataSource().getNotes(snapshot);
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final note = notesList[index];
                  return Note_Widget(note);
                },
                itemCount: notesList.length,
              );
            }),
      ),
    );
  }

  TextEditingController? title = TextEditingController();
  TextEditingController? subTitle = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  int listIndex = 0;
  String? tagIndex;

  void UpdateController() {
    title = TextEditingController();
    subTitle = TextEditingController();
    listIndex = 0;
    tagIndex = null;
  }


  Widget TagSelect() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.sell_outlined,
              color: customBackgroundColor,
              size: 35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2.0, color: Colors.grey.shade400),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      taskTag_hint,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    items: taskTag
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ))
                        .toList(),
                    value: tagIndex,
                    onChanged: (String? value) {
                      dropDownState(() {
                        tagIndex = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 10, bottom: 5, top: 5),
                    ),
                    underline: const Text(''),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showToastMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(addTask_toast),
    ));
  }

  void getDialog(String dialogTitle) {
    Dialog taskDialog = Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                //Title
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 25, bottom: 25),
                  child: Text(
                    dialogTitle,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TitleWidgets(),
                SizedBox(height: 10),
                SubTitleWidgets(),
                SizedBox(height: 10),
                TagSelect(),
              ],
            ),
          ),
          Buttons(),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => taskDialog,
    );
  }

  Widget TitleWidgets() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.list_alt,
              color: customBackgroundColor,
              size: 35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                maxLength: 20,
                controller: title,
                focusNode: _focusNode1,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  hintText: taskTitle_hint,
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xffc5c5c5),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: custom_gren,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget SubTitleWidgets() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.chat_bubble_outline,
              color: customBackgroundColor,
              size: 35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 2,
                controller: subTitle,
                focusNode: _focusNode2,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  hintText: taskSubTitle_hint,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xffc5c5c5),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: custom_gren,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget TagsSelect() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.sell_outlined,
              color: customBackgroundColor,
              size: 35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2.0, color: Colors.grey.shade400),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton<int>(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      isExpanded: true,
                      iconSize: 35,
                      hint: Text(taskTag_hint),
                      value: listIndex,
                      items: <int>[0, 1, 2].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            taskTag[value],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        dropDownState(() {
                          listIndex = value!;
                        });
                      });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Buttons() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              color: Colors.grey,
              child: Text(
                cancelButton,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              color: customBackgroundColor,
              child: Text(
                addTask_text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                FireStore_DataSource()
                    .AddNote(subTitle!.text, title!.text, listIndex);
                Navigator.pop(context);

                showToastMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
