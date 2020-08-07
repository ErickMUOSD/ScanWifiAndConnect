import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

showAlertDialog(BuildContext context, String valueText1, String valueText2,
    String valueAnimation) {
  return showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
            image: Image.asset(
              'animations/animation$valueAnimation.gif',
              fit: BoxFit.cover,
            ),
            title: Text(
              valueText1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            description: Text(
              valueText2,
              textAlign: TextAlign.center,
            ),
            entryAnimation: EntryAnimation.RIGHT,
            onlyOkButton: true,
            buttonOkColor: Colors.green,
            onOkButtonPressed: () {
              Navigator.of(context).pop();
            },
          ));
}

showInputDialog(BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Full Name', hintText: 'eg. John Smith'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: Text('Connect'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      });
}
