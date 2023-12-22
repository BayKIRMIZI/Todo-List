import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Data/FireStore.dart';
import 'package:todo_list/Widgets/Note_Widget.dart';
import 'package:todo_list/Widgets/Task_Widgets.dart';

class Stream_Note extends StatefulWidget {
  bool isDone;
  Stream_Note(this.isDone, {super.key});

  @override
  State<Stream_Note> createState() => _Stream_NoteState();
}

class _Stream_NoteState extends State<Stream_Note> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
              //return DismissibleTask(note);
              return Note_Widget(note);
            },
            itemCount: notesList.length,
          );
        });
  }

  Widget DismissibleTask(final note){
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        FireStore_DataSource().DeleteNote(note.id);
      },
      //child: Task_Widget(note),
      child: Note_Widget(note),
    );
  }
}
