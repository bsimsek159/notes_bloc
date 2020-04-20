import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesbloc/features/note_list/bloc/note_list_bloc.dart';
import 'package:notesbloc/features/note_list/bloc/note_list_event.dart';
import 'package:notesbloc/features/note_list/bloc/note_list_state.dart';
import 'package:notesbloc/models/visibility_filter.dart';
import 'package:notesbloc/resources/resources.dart';

class FilterButton extends StatelessWidget {
  FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme.of(context).textTheme.body1.copyWith(color: primaryColor);
    return BlocBuilder<NoteListBloc, NoteListState>(
      builder: (context, state) {
        return _CustomButton(
          onSelected: (filter) {
            BlocProvider.of<NoteListBloc>(context).add(UpdateFilter(filter));
          },
          activeFilter: state is NoteListLoaded
              ? state.activeFilter
              : VisibilityFilter.all,
          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );
      },
    );
  }
}

class _CustomButton extends StatelessWidget{
  const _CustomButton({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle
  }) : super(key : key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: Keys.filter_button,
      tooltip: Strings.toolTipFilterButton,
      onSelected: onSelected,
      icon: Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>> [
        PopupMenuItem<VisibilityFilter>(
          key: Keys.all_filter,
          value: VisibilityFilter.all,
          child: Text(
           Strings.allFilter,
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: Keys.important_filter,
          value: VisibilityFilter.important,
          child: Text(
            Strings.importantFilter,
            style: activeFilter == VisibilityFilter.important
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
    );
  }
}