import 'package:flutter/material.dart';
import 'constants.dart';
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


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: kColors[5],
          ),
          ListView(
            children: List.generate(
                6,
                (index) => Transform.translate(
                    offset: Offset(100 * index.toDouble() - 210,
                        -77 * index.toDouble() + 29),
                    child: Transform.rotate(
                        angle: 90, child: Columna(kColors[index])))),
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
                          color: kColors[3],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                    Card(
                       child:ListTile(
                         leading: Icon(
                           Icons.check,
//                          color: colors[3],
                           color: Colors.green,
                         ),
                         title: Text(
                           'This application is just for fun!!',
                           style: TextStyle(
                             fontSize: 15.0,
                             fontFamily: 'Bitter',
                           ),
                         ),
                         subtitle: Text(
                           'It can only connect networks called "Ubee1829 etc"'
                         ),

                       )

                    ),
                    Cards(
                      text: 'Enable Wifi and location',

                    ),
                    Cards(
                      text: 'Go to Scan wifi Page',

                    ),
                    Cards(
                      text: 'Pull to refresh the screen',

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
  Cards({this.text});

  final String text;

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
