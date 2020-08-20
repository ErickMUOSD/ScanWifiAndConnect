import 'package:app/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';
import 'constants.dart';
import 'buttonbar.dart';
import 'functions.dart';

WifiConfiguration wifiConfiguration;

class Scanwifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  WifiNetwork wifiNetwork;
  List<WifiNetwork> wifiNetworkListLocal = List();
  WifiBrain wifi;
  @override
  void initState() {
    super.initState();
       getList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColors[3],
      appBar: AppBar(
        elevation: 10,
        backgroundColor: kColors[1],
        centerTitle: true,
        title: Text(
          "Scan wifi",
          style: TextStyle(fontFamily: 'Bitter', fontSize: 35.0),
        ),
      ),
      body: widgets(),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        tooltip: 'Tap to connect  manually',
        onPressed: () {
     showInputDialog(context);
        },
        label: Text(
          'Manually',
          style: TextStyle(fontSize: 13.0, color: Colors.black),
        ),
        icon: Icon(
          Icons.add_circle,
          color: kColors[1],
        ),
      ),
    );
  }



  Column widgets() {
    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              setState(() {
               // _wifiNetworkList.removeRange(0, _wifiNetworkList.length);
              });
              await _refreshList();
            },
            child: ListView.builder(
                itemCount: wifiNetworkListLocal.length ,
                itemBuilder: (context, int index) {
                 wifiNetwork = wifiNetworkListLocal[index];
                  //_checkStateColor(wifiNetwork.ssid.substring(0, 4));
                  return Cards(
                    iconWifi: wifi.isWell(wifiNetwork.ssid.substring(0,4)) ? Icons.network_wifi : Icons.wifi_lock,
                    colorRedOrGreen: wifi.isWell(wifiNetwork.ssid.substring(0,4)) ? kGreenColor : kRedColor,
                    textBssid: wifiNetwork.bssid,
                    textSsid: wifiNetwork.ssid,
                    textMightAbleToConnect: wifi.textMightBeAbleToConnect(wifiNetwork.ssid.substring(0,4)),
                    press: () {

                       wifi.setValuesToConnect(wifiNetwork.ssid,wifiNetwork.bssid,wayToConnectWifi.connectedAutomatically);
                          showingAlertDialog(context);

    },
                  );
                }),
          ),
        ),
      ],
    );
  }



  void getList() async {
    wifi = WifiBrain();
    await wifi.getWifiList();
    setState(() {
     wifiNetworkListLocal=   wifi.wifiNetworkList;
    });

  }
void showingAlertDialog(BuildContext context) async{
   await wifi.getConnectionState(wifi.NetWorkName, wifi.Paswword);
   showAlertDialog(context, wifi.valueTextDialog1, wifi.valueTextDialog2, wifi.valueAnimation);
}


  Future<Null> _refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    getList();
    return null;
  }
}

class Cards extends StatelessWidget {
  Cards(
      {this.colorRedOrGreen,
      this.textBssid,
      this.textMightAbleToConnect,
      this.iconWifi,
      this.press,
      this.textSsid});
  final IconData iconWifi;
  final String textBssid;
  final String textMightAbleToConnect;
  final Color colorRedOrGreen;
  final Function press;
  final String textSsid;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Icon(
                  iconWifi,
                  color: colorRedOrGreen,
                ),
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
                      textSsid,
                      style: kStyleSsid,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      textBssid,
                      style: kStyleBssid,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      textMightAbleToConnect,
                      style: TextStyle(
                          color: colorRedOrGreen,
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro'),
                    ),
                  )
                ],
              )
            ],
          ),
          ButtonBars(
            onpress: press,
            childs: Text(
              'Connect',
              style: kStyleButton,
            ),
          )
        ],
      ),
    );
  }
}
