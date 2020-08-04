import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Information',
      home: HomePage(),
    );
  }
}

final List<Color> colors = [
  Color(0xff184042),
  Color(0xff255152),
  Color(0xff365F61),
  Color(0xff4A7375),
  Color(0xff5D8587),
  Color(0xff7BA2A4),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: colors[5],
          ),
          ListView(
            children: List.generate(
                6,
                (index) => Transform.translate(
                    offset: Offset(100 * index.toDouble() - 210,
                        -77 * index.toDouble() + 29),
                    child: Transform.rotate(
                        angle: 90, child: Columna(colors[index])))),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Instructions',
                        style: TextStyle(
                          color: colors[3],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                    Cards(
                      text: 'This application is just for fun!!',
                      subtitle:
                          'It can only connect networks which starts with "Ubee"',
                    ),
                    Cards(
                      text: 'Enable Wifi and location',
                      subtitle: '',
                    ),
                    Cards(
                      text: 'Go to Scan wifi Page',
                      subtitle: '',
                    ),
                    Cards(
                      text: 'Pull to refresh the screen',
                      subtitle: '',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  Cards({this.text, this.subtitle});

  final String text;
  final String subtitle ;
  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        leading: Icon(
          Icons.check,
//                          color: colors[3],
          color: Colors.green,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Bitter',
          ),
        ),
        subtitle: Text(subtitle,
        style: TextStyle(
          fontSize: 15.0,
        ),),
      ),
    );
  }
}

class Columna extends StatelessWidget {
  final Color bgColor;
  Columna(this.bgColor);
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
//      height: size.width * 0.25,
      height: 100,
      decoration: BoxDecoration(color: bgColor),
    );
  }
}
