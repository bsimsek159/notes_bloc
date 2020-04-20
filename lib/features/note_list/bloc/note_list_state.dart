import 'package:equatable/equatable.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/models/visibility_filter.dart';

abstract class NoteListState extends Equatable{
  const NoteListState();
  @override
  List<Object> get props => [];
}

class NoteListLoading extends NoteListState{}

class NoteListLoaded extends NoteListState{
  final List<Note> notes;
  final VisibilityFilter activeFilter;

  const NoteListLoaded(this.notes, this.activeFilter);
  @override
  List<Object> get props => [notes, activeFilter];

  @override
  String toString() {
    return 'NoteListLoaded{filteredNotes: $notes, activeFilter: $activeFilter}';
  }
}
