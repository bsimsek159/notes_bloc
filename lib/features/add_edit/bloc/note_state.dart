import 'package:equatable/equatable.dart';
import 'package:notesbloc/models/note.dart';

abstract class NoteState extends Equatable{
  const NoteState();

  @override
  List<Object> get props => [];
}

class NotesLoaded extends NoteState{
  final List<Note> notes;
  const NotesLoaded([this.notes = const []]);
  @override
  List<Object> get props => [notes];
  @override
  String toString() => 'StateNoteLoaded';
}

class NotesLoading extends NoteState{}

class NotesNotLoaded extends NoteState {}