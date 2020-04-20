import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesbloc/resources/resources.dart';

import 'features/add_edit/bloc/note_bloc.dart';
import 'features/add_edit/bloc/note_event.dart';
import 'features/add_edit/ui/add_edit_note_screen.dart';
import 'features/home/home_screen.dart';
import 'features/note_list/bloc/note_list_bloc.dart';
import 'models/note.dart';

void main() {
  runApp(BlocProvider(
    create: (context) {
      return NoteBloc()..add(LoadNotes());
    },
    child: NoteTakingApp(),
  ));
}

class NoteTakingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appBarTitle,
      theme: appThemeData[AppTheme.Light],
      darkTheme: appThemeData[AppTheme.Dark],
      routes: {
        Routes.home: (context) {
          return BlocProvider<NoteListBloc>(
              create: (context) => NoteListBloc(
                  noteBloc: BlocProvider.of<NoteBloc>(context)
              ),
              child: HomeScreen()
          );
        },
        Routes.addEditNote: (context) {
          return AddEditScreen(
            key: Keys.add_edit_note_screen,
            onSave: (title, noteContent, isFlagged) {
              BlocProvider.of<NoteBloc>(context).add(
                AddNote(Note(title: title, noteContent: noteContent, isFlagged: isFlagged)),
              );
            },
          );
        }
      },
    );
  }
}
