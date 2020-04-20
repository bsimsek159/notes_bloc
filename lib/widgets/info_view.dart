import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesbloc/resources/resources.dart';

class InfoView extends StatelessWidget{
  InfoView({Key key, this.info, this.imagePath}): super(key: key);
  final String info;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            height: infoImageSize,
            width: infoImageSize,
            color: Theme.of(context).primaryColor,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: EdgeInsets.all(dimen16dp),
            child: Text(info),
          )
        ],
      )
    );
  }
}