import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:notesbloc/database/notes_repository.dart';
import 'package:notesbloc/models/note.dart';

import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final _notesRepository = NotesRepository();

  NoteBloc(){
    _notesRepository.getAllNotes();
  }

  @override
  NoteState get initialState => NotesLoading();

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is LoadNotes) {
      yield* _mapNoteLoadToState();
    } else if (event is AddNote) {
      yield* _mapNoteAddToState(event);
    } else if (event is EditNote) {
      yield* _mapNoteEditToState(event);
    } else if (event is DeleteNote) {
      yield* _mapNoteDeleteToState(event);
    }
  }

  Stream<NoteState> _mapNoteLoadToState() async* {
    try {
      final notes = await this._notesRepository.getAllNotes();
      yield NotesLoaded(notes);
    } catch (_) {
      yield NotesNotLoaded();
    }
  }

  Stream<NoteState> _mapNoteAddToState(AddNote event) async* {
    if(state is NotesLoaded) {
      _notesRepository.insertNote(event.note);
      final List<Note> notes = List.from((state as NotesLoaded).notes)..add(event.note);
      yield NotesLoaded(notes);
    }
  }

  Stream<NoteState> _mapNoteEditToState(EditNote event) async* {
    if (state is NotesLoaded) {
      _notesRepository.updateNote(event.editedNote);
      final List<Note> updatedNotes = (state as NotesLoaded).notes.map((note) {
        return note.id == event.editedNote.id ? event.editedNote : note;
      }).toList();
      yield NotesLoaded(updatedNotes);
    }
  }

  Stream<NoteState> _mapNoteDeleteToState(DeleteNote event) async* {
    if(state is NotesLoaded){
      _notesRepository.deleteNote(event.deletedNote.id);
      final List<Note> updatedNotes = (state as NotesLoaded)
          .notes
          .where((note) => note.id != event.deletedNote.id)
          .toList();
      yield NotesLoaded(updatedNotes);
    }
  }

  @override
  void onEvent(NoteEvent event) {
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
