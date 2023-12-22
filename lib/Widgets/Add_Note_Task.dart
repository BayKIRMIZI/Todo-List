import 'package:flutter/material.dart';
import 'package:todo_list/Colors/Colors.dart';
import 'package:todo_list/Data/FireStore.dart';
import 'package:todo_list/Model/Notes_Model.dart';
import 'package:todo_list/Strings/String_Texts.dart';

class Add_Note_Task extends StatefulWidget {
  BuildContext context;

  Add_Note_Task(this.context, {super.key});

  @override
  State<Add_Note_Task> createState() => _Add_Note_TaskState();
}

class _Add_Note_TaskState extends State<Add_Note_Task> {

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [

      ],
    );
  }

}

/*
class AddNoteWidget{
  Note? _note;
  bool? isAdd;

  AddNoteWidget(this._note, this.isAdd);



  final title = TextEditingController();
  final subTitle = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  int listIndex = 0;

  void getDialog(BuildContext context, String dialogTitle) {
    Dialog taskDialog = Dialog(
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
                //SizedBox(height: 50),
                //SizedBox(height: 10),
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

  static Widget TitleWidgets() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.description_outlined,
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
                controller: title,
                focusNode: _focusNode1,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  hintText: taskTitle_hint,
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

  static Widget SubTitleWidgets() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.chat_bubble_outline,
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
                maxLines: 2,
                minLines: 1,
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

  static Widget TagSelect() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 5),
            child: Icon(
              Icons.discount_outlined,
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
                          print(listIndex);
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

  static Widget Buttons() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              color: Colors.grey,
              child: Text(cancelButton, style: const TextStyle(color: Colors.white, fontSize: 20),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              color: customBackgroundColor,
              child: Text(addTask_text, style: const TextStyle(color: Colors.white, fontSize: 20), ),
              onPressed: () {
                FireStore_DataSource()
                    .AddNote(subTitle.text, title.text, listIndex);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

}*/