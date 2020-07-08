import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'datanetwork.dart';

void main() => runApp(Myapp());

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
 // WiFiInfoWrapper _wifiObject;
  dataNetwork  getDataBrain = new dataNetwork();
  bool isGood;
  List listName, listMac;
  @override
  void initState() {
    super.initState();
    isGood = false;
    getDataBrain.scanWiFi();


  }
@override
  Widget build(BuildContext context) {
   getDataBrain.scanHandler();


    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Connect wifi"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => getDataBrain.scanHandler(),
            )
          ],
        ),
        body: getListView(),
      ),
    );
  }




  Widget getListView() {

    listName = getDataBrain.getListSsid();
    listMac = getDataBrain.getListBssid();
    var listView = ListView.builder(
      itemCount: listName.length,
        itemBuilder: (context, index) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            ListTile(
//              leading: Icon(Icons.wifi_lock),
//              title: Text(listName[index]),
//              subtitle: Text(listMac[index]),
//            ),
            Row(

              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: getIcon(),
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        listName[index],
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        listMac[index],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'listSecurity[index]',
                      ),
                    )
                  ],
                )
              ],
            ),

            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Copy Mac'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Delete'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Connect'),
                  onPressed: () {
                    // datanet.scanHandler();

                  },
                ),
              ],
            ),
          ],
        ),
      );
    });

    return listView;

  }
 void checkStatIcon(){

 }
  Icon getIcon() {
checkStatIcon();
    if (isGood) {
      return Icon(
        Icons.wifi,
        size: 30,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.wifi_lock,
        size: 30,
        color: Colors.red,
      );
    }
  }


}


