import 'package:flutter/material.dart';
import 'constants.dart';
class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kColors[2],
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('images/Erick_photo.jpg'),
              ),
              Texts(
                text: 'Erick Sanabria',
                fontsize: 40.0,
                fontfamily: 'Pacifico',
              ),
              Texts(
                text: 'Flutter Developer',
                fontfamily: 'Source Sans Pro',
                fontsize: 20.0,
                letterSpacing: 1.5,
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Cards(
                text1: '722802713',
                icon1: Icons.phone,
              ),
              Cards(
                text1: 'Martinoli944@gmail.com, ',
                icon1: Icons.email,
              ),
              Texts(
                text:
                    'This app is just for funn!! and for recreational purposes',
                fontsize: 13,
                fontfamily: 'Source Sans pro',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  Texts({this.text, this.fontsize, this.fontfamily, this.letterSpacing});
  final String text;
  final double fontsize;
  final fontfamily;
  final letterSpacing;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          letterSpacing: letterSpacing,
          fontFamily: fontfamily,
          fontSize: fontsize,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
}

class Cards extends StatelessWidget {
  Cards({this.text1, this.icon1});
  final String text1;
  final IconData icon1;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          icon1,
          color: kColors[2],
        ),
        title: Text(
          text1,
          style: TextStyle(
            color: Colors.teal.shade900,
            fontFamily: 'Source Sans pro',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
