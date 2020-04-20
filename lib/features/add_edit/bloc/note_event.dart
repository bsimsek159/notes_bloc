import 'package:equatable/equatable.dart';
import 'package:notesbloc/models/note.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];

  @override
  String toString() =>"AddNote { note ${note.id} }";
}

class EditNote extends NoteEvent {
  final Note editedNote;

  const EditNote(this.editedNote);

  @override
  List<Object> get props => [editedNote];

  @override
  String toString() => "EditNote { editedNote ${editedNote.id} }";
}

class DeleteNote extends NoteEvent {
  final Note deletedNote;

  const DeleteNote(this.deletedNote);

  @override
  List<Object> get props => [deletedNote];

  @override
  String toString() => "DeleteNote { deletedNote ${deletedNote.id} }";
}