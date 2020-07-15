import 'package:flutter/material.dart';
class Page1  extends StatelessWidget {
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
                height: size.height * 0.7,
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
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Information',
                        style: TextStyle(
                          color: colors[3],
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: colors[3],
                        ),
                        title: Text(
                          'This application allows you to connect some networks',
                          style: TextStyle(

                            fontFamily: 'Bitter',
                          ),
                        ),
                        subtitle: Text(
                            'It can only connect networks which starts with "Ubee"'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: colors[3],
                        ),
                        title: Text(
                          'How do i know if i am able to  connect to a network?',
                          style: TextStyle(

                            fontFamily: 'Bitter',
                          ),
                        ),
                        subtitle: Text(
                            'The application will show you a green network.'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.yellow,
                        ),
                        title: Text(
                          'Why does the application always show me red networks?',
                          style: TextStyle(
                            fontFamily: 'Bitter',

                          ),
                        ),
                        subtitle: Text(
                            'Be patient... You need to find a green networks'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.red,
                        ),
                        title: Text(
                          'What can i do if my router is able to connect with this application?',
                          style: TextStyle(
                            fontFamily: 'Bitter',
                          ),
                        ),
                        subtitle: Text(
                            'You need to change your router\'s information. Contact your internet provider'),
                      ),
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