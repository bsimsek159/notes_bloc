import 'package:equatable/equatable.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/models/visibility_filter.dart';

abstract class NoteListEvent extends Equatable{
  const NoteListEvent();
}

class UpdateNotes extends NoteListEvent{
  final List<Note> notes;

  const UpdateNotes(this.notes);
  @override
  List<Object> get props => [notes];
  @override
  String toString() => 'UpdateNotes { notes: $notes}';
}

class UpdateFilter extends NoteListEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}