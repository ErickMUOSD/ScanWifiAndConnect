import 'package:app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'scanwifi.dart';

final myController1 = TextEditingController();
final myController2 = TextEditingController();

Scanwifi wifi = Scanwifi();

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
          title: Text(
            'Connect manually',
            style: TextStyle(
              color: kColors[3],
              fontSize: 25.0,
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: myController1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10.0, left: 20.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Ssid Name',
                    hintText: 'eg. Abb4e 2.4g'),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                controller: myController2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10.0, left: 20.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Password',
                    hintText: 'eg. Abb4e 2.4g'),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: kColors[4],
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: Text(
                  'Connect',
                  style: TextStyle(
                    color: kColors[4],
                    fontSize: 15.0,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  print(myController1.text);
                  print(myController2.text);

                })
          ],
        );
      });
}
