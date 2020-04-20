import 'package:flutter/cupertino.dart';

class Keys{
  //Screen Keys
  static final home_screen = const Key('_homeScreen');
  static final add_edit_note_screen = const Key('_addEditNoteScreen');

  //Note List Widgets
  static final note_list = const Key('_noteList');

  //AddEdit Screen Widgets
  static final app_bar_add_edit = const Key('_appBar');
  static final flag_icon = const Key('_flagIcon');
  static final delete_icon = const Key('_deleteIcon');
  static final save_icon = const Key('_saveIcon');

  //Form fields
  static final form_title = const Key('_titleFormInput');
  static final form_content = const Key('_contentFormInput');

  //HomeScreen
  static final app_bar_home = const Key('_appBarHome');
  static final add_note_button = const Key('_addNoteFB');
  static final all_filter = const Key('_showAll');
  static final important_filter = const Key('_showImportant');

  //Custom Widgets
  static final snack_bar = const Key('_snackBar');
  static final notes_loading = const Key('_notesLoading');
  static final filter_button = const Key('_filterButton');
  static final more_actions_button = const Key('_moreActions');
  static final info_view = const Key('_infoView');

  //Note Item Widget
  static final note_item = (String id) => Key('_noteItem__${id}');
  static final dismissable_item = Key('_dismissableItem');





}