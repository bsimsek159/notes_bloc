import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesbloc/features/add_edit/bloc/note_bloc.dart';
import 'package:notesbloc/features/add_edit/bloc/note_event.dart';
import 'package:notesbloc/features/add_edit/bloc/note_state.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/resources/resources.dart';
import 'package:notesbloc/widgets/custom_alert_dialog.dart';

typedef OnSaveCallback = Function(
    String title, String noteContent, bool isFlagged);

class AddEditScreen extends StatefulWidget {
  final bool isImportant;
  final String id;
  final OnSaveCallback onSave;

  AddEditScreen({
    Key key,
    @required this.onSave,
    this.isImportant,
    this.id,
  }) : super(key: key ?? Keys.add_edit_note_screen);

  @override
  State<StatefulWidget> createState() =>
      _AddEditScreenState(id, isImportant ?? false);
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _noteInputFormKey = GlobalKey<FormState>();

  bool _isFlagged;
  bool _isEditing;
  String _noteId;
  String _noteTitle;
  String _noteContent;

  _AddEditScreenState(this._noteId, this._isFlagged);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      _isEditing = _noteId != null ? true : false;
      Note _note = (state as NotesLoaded)
          .notes
          .firstWhere((note) => note.id == _noteId, orElse: () => Note());
      return Scaffold(
        appBar: AppBar(
          key: Keys.app_bar_add_edit,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (_isEditing)
                  _saveAlert();
                else
                  Navigator.of(context).pop();
              }),
          actions: <Widget>[
            IconButton(
                key: Keys.flag_icon,
                tooltip: Strings.toolTipFlag,
                color: _isFlagged ? redColor : null,
                icon: Icon(_isFlagged ? Icons.flag : Icons.outlined_flag),
                padding: EdgeInsets.only(right: dimen32dp),
                onPressed: () {
                  setState(() {
                    _isFlagged = !_isFlagged;
                  });
                }),
            Visibility(
              visible: _isEditing,
              child: IconButton(
                key: Keys.delete_icon,
                icon: Icon(Icons.delete),
                padding: EdgeInsets.only(right: dimen32dp),
                onPressed: () {
                  BlocProvider.of<NoteBloc>(context).add(DeleteNote(_note));
                  Navigator.of(context).pop(_note);
                },
              ),
            ),
            IconButton(
                key: Keys.save_icon,
                icon: Icon(Icons.save),
                onPressed: () {
                  _saveAction();
                },
                padding: EdgeInsets.only(right: dimen32dp))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(dimen16dp),
          child: Form(
            key: _noteInputFormKey,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: dimen14dp),
                    child: TextFormField(
                      key: Keys.form_title,
                      initialValue: _isEditing ? _note?.title : Strings.BLANK,
                      autofocus: !_isEditing,
                      maxLines: null,
                      style: textTheme.headline,
                      decoration: InputDecoration(hintText: Strings.titleHint),
                      onSaved: (title) => _noteTitle = title,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: dimen14dp),
                  child: TextFormField(
                    key: Keys.form_content,
                    initialValue:
                        _isEditing ? _note?.noteContent : Strings.BLANK,
                    maxLines: 20,
                    style: textTheme.subhead,
                    decoration: InputDecoration(hintText: Strings.contentHint),
                    validator: (val) {
                      return val.trim().isEmpty
                          ? Strings.contentValidator
                          : null;
                    },
                    onSaved: (noteText) => _noteContent = noteText,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void _saveAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            dialogContent: Strings.saveAlertContent,
            positiveButton: FlatButton(
              child: Text(Strings.positiveButtonText,
                  style: Styles.positiveButtonStyle),
              onPressed: () {
                _saveAction();
                Navigator.of(context).pop();
              },
            ),
            negativeButton: FlatButton(
              child: Text(Strings.negativeButtonText,
                  style: Styles.negativeButtonStyle),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  void _saveAction() {
    if (_noteInputFormKey.currentState.validate()) {
      _noteInputFormKey.currentState.save();
      widget.onSave(_noteTitle, _noteContent, _isFlagged);
      Navigator.of(context).pop();
    }
  }
}
