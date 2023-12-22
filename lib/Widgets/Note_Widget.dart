import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/Colors/Colors.dart';
import 'package:todo_list/Data/FireStore.dart';
import 'package:todo_list/Model/Notes_Model.dart';
import 'package:todo_list/Screen/Edit_Screen.dart';
import 'package:todo_list/Strings/String_Texts.dart';

class Note_Widget extends StatefulWidget {
  Note _note;

  Note_Widget(this._note, {super.key});

  @override
  State<Note_Widget> createState() => _Note_WidgetState();
}

class _Note_WidgetState extends State<Note_Widget> {
  TextEditingController? title;
  TextEditingController? subTitle;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = TextEditingController(text: widget._note.title);
    subTitle = TextEditingController(text: widget._note.subTitle);
    listIndex = widget._note.tagIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              // ana resim
              TaskIcon(),

              const SizedBox(width: 25),
              // Başlık ve alt başlık
              TaskStrings(),

              TaskPopUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget TaskIcon() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10),
      alignment: Alignment.topCenter,
      child: Icon(
        //Icons.catching_pokemon,
        Icons.circle,
        color: taskColor[widget._note.tagIndex],
      ),
    );
  }

  Widget TaskStrings() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget._note.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            widget._note.subTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
            ),
          ),
          const Spacer(),

          // Edit ve Time butonları
          //EditButtons(),
        ],
      ),
    );
  }

  Widget TaskPopUpButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PopupMenuButton(
        iconSize: 30,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(popUpEdit),
            onTap: () {
              print(widget._note.title);
              UpdateController();
              getDialog(updateTask_Title);
            },
          ),
          PopupMenuItem(
            child: Text(popUpDelete),
            onTap: () {
              FireStore_DataSource().DeleteNote(widget._note.id);
              showToastMessage(deleteTask_toast);
            },
          ),
        ],
      ),
    );
  }

  void UpdateController(){
    title = TextEditingController(text: widget._note.title);
    subTitle = TextEditingController(text: widget._note.subTitle);
    listIndex = widget._note.tagIndex;
  }

  void showToastMessage(String _msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_msg),
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
                updateTask_text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                FireStore_DataSource().UpdateNote(
                    widget._note.id, listIndex, title!.text, subTitle!.text);
                Navigator.pop(context);
                showToastMessage(upadteTask_toast);
              },
            ),
          ),
        ],
      ),
    );
  }
}
