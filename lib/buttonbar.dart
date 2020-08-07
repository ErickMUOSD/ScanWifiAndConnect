import 'package:flutter/material.dart';
import 'constants.dart';

class ButtonBars extends StatelessWidget {
  ButtonBars({this.onpress,  this.childs});
  final Function onpress;

  final Widget childs;
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[ RaisedButton(
        onPressed: onpress,
        textColor: Colors.white,
        color: kColors[1],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        child: childs,
        animationDuration: Duration(seconds: 2),
      ),]
    );
  }
}
