import 'package:notesbloc/models/note.dart';

import 'dao/note_dao.dart';

class NotesRepository{
  final noteDao = NoteDao();

  Future getAllNotes() => noteDao.getAllNotes();

  Future insertNote(Note note) => noteDao.createNote(note);

  Future updateNote(Note note) => noteDao.updateItem(note);

  Future deleteNote(String id) => noteDao.deleteItem(id);
}