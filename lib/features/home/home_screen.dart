import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesbloc/resources/resources.dart';
import 'package:notesbloc/widgets/filter_button.dart';
import '../note_list/ui/note_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Keys.app_bar_home,
        title: Text(Strings.appBarTitle,
            overflow: TextOverflow.clip,
            softWrap: false,
            style: Styles.appBarTitleStyle),
        actions: <Widget>[
          FilterButton(),
        ],
      ),
      body: NoteList(),
      floatingActionButton: FloatingActionButton(
        key: Keys.add_note_button,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEditNote);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
