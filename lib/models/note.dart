import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notesbloc/database/constants.dart';

class Note {
  final String id;
  String title;
  String noteContent;
  final String date;
  bool isFlagged;

  Note({String id, String title, String noteContent, String date, bool isFlagged})
      : this.id = id ?? UniqueKey().toString(),
        this.date = DateFormat.yMd().add_jm().format(DateTime.now()),
        this.title = title ?? "",
        this.noteContent = noteContent ?? "",
        this.isFlagged = isFlagged ?? false;

  Note copyWith({String id, String title, String noteContent, String date, bool isFlagged}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      noteContent: noteContent ?? this.noteContent,
      date: date ?? this.date,
      isFlagged: isFlagged ?? this.isFlagged
    );
  }

  factory Note.fromDatabaseJson(Map<String, dynamic> data) => Note(
      id: data['${Constants.COLUM_ID}'] ?? UniqueKey().toString(),
      title: data['${Constants.COLUM_TITLE}'],
      noteContent: data['${Constants.COLUM_NOTE_CONTENT}'],
      date: data['${Constants.COLUM_DATE}'] ?? DateFormat.yMd().add_jm().format(DateTime.now()),
      isFlagged: data['${Constants.COLUM_IS_FLAGGED}'] == 1 ? true : false);

  Map<String, dynamic> toDatabaseJson() => {
        "${Constants.COLUM_ID}": this.id,
        "${Constants.COLUM_TITLE}": this.title,
        "${Constants.COLUM_NOTE_CONTENT}": this.noteContent,
        "${Constants.COLUM_DATE}": this.date,
        "${Constants.COLUM_IS_FLAGGED}": this.isFlagged == true ? 1 : 0,
      };
}
