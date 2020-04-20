import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PositiveButtonCallBack = Function();
typedef NegativeButtonCallBack = Function();

class CustomAlertDialog extends StatelessWidget{
  CustomAlertDialog({Key key, this.dialogTitle, @required this.dialogContent, this.positiveButton, this.negativeButton}): super(key: key);
  final String dialogTitle;
  final String dialogContent;
  final Widget positiveButton;
  final Widget negativeButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: dialogTitle != null ? Text(dialogTitle) : null,
      content: Text(dialogContent),
      actions: <Widget> [
        positiveButton,
        negativeButton,
      ],
    );
  }
}