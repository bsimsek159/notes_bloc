import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesbloc/features/add_edit/bloc/note_bloc.dart';
import 'package:notesbloc/features/add_edit/bloc/note_event.dart';
import 'package:notesbloc/features/add_edit/ui/add_edit_note_screen.dart';
import 'package:notesbloc/resources/keys.dart';
import 'package:notesbloc/resources/resources.dart';
import 'package:notesbloc/widgets/delete_note_snack_bar.dart';
import 'package:notesbloc/widgets/info_view.dart';
import 'package:notesbloc/widgets/loading.dart';
import 'package:notesbloc/widgets/note_item.dart';

import '../bloc/note_list_bloc.dart';
import '../bloc/note_list_state.dart';

class NoteList extends StatelessWidget {
  NoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteListBloc, NoteListState>(builder: (context, state) {
      if (state is NoteListLoading) {
        return BaseLoadingView(key: Keys.notes_loading);
      } else if (state is NoteListLoaded) {
        final notes = state.notes;
        return notes.isEmpty
            ? InfoView(
                info: Strings.emptyNoteListInfo,
                imagePath: 'assets/images/empty_list.png')
            : ListView.builder(
                key: Keys.note_list,
                itemCount: notes.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  final note = notes[index];
                  return NoteItem(
                    key: Keys.note_item(note.id),
                    note: note,
                    onDismissed: (direction) {
                      BlocProvider.of<NoteBloc>(context).add(DeleteNote(note));
                      Scaffold.of(context).showSnackBar(DeleteNoteSnackBar(
                          key: Keys.snack_bar,
                          note: note,
                          onUndo: () => BlocProvider.of<NoteBloc>(context)
                              .add(AddNote(note))));
                    },
                    onTap: () async {
                      final removedNote = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return AddEditScreen(
                          key: Keys.add_edit_note_screen,
                          id: note.id,
                          isImportant: note.isFlagged,
                          onSave: (title, noteContent, isFlagged) {
                            BlocProvider.of<NoteBloc>(context).add(
                              EditNote(note.copyWith(
                                  title: title,
                                  noteContent: noteContent,
                                  isFlagged: isFlagged)),
                            );
                          },
                        );
                      }));
                      if (removedNote != null) {
                        Scaffold.of(context).showSnackBar(DeleteNoteSnackBar(
                            key: Keys.snack_bar,
                            note: note,
                            onUndo: () => BlocProvider.of<NoteBloc>(context)
                                .add(AddNote(note))));
                      }
                    },
                    onFlagged: (isFlagged) {
                      BlocProvider.of<NoteBloc>(context).add(
                        EditNote(note.copyWith(isFlagged: isFlagged)),
                      );
                    },
                  );
                });
      } else {
        return InfoView(info: Strings.listErrorInfo);
      }
    });
  }
}
