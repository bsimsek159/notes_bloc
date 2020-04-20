import 'package:flutter/material.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/resources/resources.dart';

class DeleteNoteSnackBar extends SnackBar {
  DeleteNoteSnackBar({
    Key key,
    @required Note note,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            Strings.snackbarInfo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
              label: Strings.snackbarAction,
            textColor: primaryColor,
            onPressed: onUndo,
          ),
        );
}
