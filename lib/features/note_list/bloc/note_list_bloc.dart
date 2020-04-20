import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:notesbloc/features/add_edit/bloc/note_bloc.dart';
import 'package:notesbloc/features/add_edit/bloc/note_state.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/models/visibility_filter.dart';

import 'note_list_event.dart';
import 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteBloc noteBloc;
  StreamSubscription notesSubscription;

  NoteListBloc({@required this.noteBloc}) {
    notesSubscription = noteBloc.listen((state) {
      if (state is NotesLoaded) {
        add(UpdateNotes((noteBloc.state as NotesLoaded).notes));
      }
    });
  }

  @override
  NoteListState get initialState {
    return noteBloc.state is NotesLoaded ? NoteListLoaded((noteBloc.state as NotesLoaded).notes, VisibilityFilter.all) : NoteListLoading();
  }

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event) async* {
    if (event is UpdateNotes) {
      yield* _mapNotesUpdatedToState(event);
    } else if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    }
  }

  Stream<NoteListState> _mapNotesUpdatedToState(UpdateNotes event) async* {
    if (noteBloc.state is NotesLoaded) {
      final visibilityFilter = state is NoteListLoaded
          ? (state as NoteListLoaded).activeFilter
          : VisibilityFilter.all;
      yield NoteListLoaded(
        _mapNotesToFilteredNotes(
          (noteBloc.state as NotesLoaded).notes,
          visibilityFilter,
        ),
        visibilityFilter,
      );
    }
  }

  Stream<NoteListState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (noteBloc.state is NotesLoaded) {
      yield NoteListLoaded(_mapNotesToFilteredNotes((noteBloc.state as NotesLoaded).notes, event.filter,), event.filter);
    }
  }

  List<Note> _mapNotesToFilteredNotes(
      List<Note> notes, VisibilityFilter filter) {
    return notes.where((todo) {
      if (filter == VisibilityFilter.important) {
        return todo.isFlagged;
      } else {
        return true;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    notesSubscription.cancel();
    return super.close();
  }

  @override
  void onEvent(NoteListEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}
