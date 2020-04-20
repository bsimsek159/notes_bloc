import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseLoadingView extends StatelessWidget{
  BaseLoadingView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
