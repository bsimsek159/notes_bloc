import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesbloc/models/note.dart';
import 'package:notesbloc/resources/resources.dart';

typedef OnFlaggedCallback = Function(bool isFlagged);

class NoteItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final OnFlaggedCallback onFlagged;
  final Note note;

  NoteItem(
      {Key key,
      @required this.onDismissed,
      @required this.onTap,
      @required this.onFlagged,
      @required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.dismissable_item,
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: dimen10dp, vertical: dimen10dp),
        decoration: BoxDecoration(
            gradient: Styles.noteItemDismissBackground
        ),
      ),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: dimen10dp, vertical: dimen10dp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimen10dp),
              boxShadow: [
                if (note.isFlagged)
                  Styles.noteItemFlaggedBoxShadow
                else
                  Styles.noteItemRegularBoxShadow
              ]),
          child: Material(
              borderRadius: BorderRadius.circular(dimen10dp),
              clipBehavior: Clip.antiAlias,
              color: Theme.of(context).dialogBackgroundColor,
              child: InkWell(
                  borderRadius: BorderRadius.circular(dimen10dp),
                  splashColor: primaryColor.withAlpha(20),
                  highlightColor: primaryColor.withAlpha(10),
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(dimen10dp),
                    child: _makeNoteChild(note),
                  )))),
    );
  }

  Widget _makeNoteChild(Note note) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    ellipsizeText(note.title.toString()),
                    style: Styles.noteItemHeaderStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: dimen10dp),
                  child: IconButton(
                      key: Keys.flag_icon,
                      tooltip: Strings.toolTipFlag,
                      color: note.isFlagged ? redColor : lightGray,
                      icon: Icon(
                          note.isFlagged ? Icons.flag : Icons.outlined_flag),
                      onPressed: () {
                        note.isFlagged = !note.isFlagged;
                        return onFlagged(note.isFlagged);
                      }),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: dimen10dp),
              child: Text(
                ellipsizeText(note.noteContent.toString()),
                textAlign: TextAlign.start,
                style: Styles.noteItemContentStyle,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: dimen10dp),
                alignment: Alignment.centerRight,
                child: Text(note.date,
                    textAlign: TextAlign.right,
                    style: Styles.noteItemDateStyle))
          ],
        ),
      );

  String ellipsizeText(String text) {
    return '${text.length <= 25 ? text.trim() : text.trim().substring(0, 25) + '...'}';
  }
}
