import 'package:wifi/wifi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';

WifiConfiguration wifiConfiguration;
void main() => runApp(MyHomePageMain());

class MyHomePageMain extends StatefulWidget {
  @override
  _MyHomePageMainState createState() => _MyHomePageMainState();
}

class _MyHomePageMainState extends State<MyHomePageMain> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  bool isGood = false;
  List<WifiNetwork> wifiNetworkList = List();
  String textMightAbleToConnect = '';
  String wifiNameToConnect = '', wifiPasswordToConnect = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wifiConfiguration = WifiConfiguration();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff4A7375),
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Color(0xff255152),
          centerTitle: true,
          title: Text(
            "Scan wifi",
            style: TextStyle(fontSize: 30.0, fontFamily: 'Bitter'),
          ),
        ),
        body: RefreshIndicator(
          key: refreshKey,
            onRefresh: ()async{
                 await refreshList();
            },
            child: listCenter()
        ),
      ),
    );
  }

  ListView listCenter() {
    return ListView.builder(
        itemCount: wifiNetworkList.length,
        itemBuilder: (context, int index) {
          WifiNetwork wifiNetwork = wifiNetworkList[index];
          checkStateColor(wifiNetwork.ssid.substring(0, 4));
          return Card(
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
                        isGood ? Icons.network_wifi : Icons.wifi_lock,
                        color: isGood ? Colors.green : Colors.red,
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
                            wifiNetwork.ssid,
                            style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                fontSize: 25.0,
                                fontFamily: 'Bitter'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            wifiNetwork.bssid,
                            style: TextStyle(fontFamily: 'Bitter'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            textMightAbleToConnect,
                            style: TextStyle(
                                color: isGood ? Colors.green : Colors.red,
                                fontSize: 15.0,
                                fontFamily: 'Source Sans Pro'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      setValuesToConnect(wifiNetwork.ssid, wifiNetwork.bssid);
                      connection();
                    },
                    textColor: Colors.white,
                    color: Color(0xff255152),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    splashColor: isGood ? Colors.green : Colors.red,
                    animationDuration: Duration(seconds: 3),
                    child: Text(
                      'Connect',
                      style: TextStyle(fontSize: 20, fontFamily: 'Bitter'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void setValuesToConnect(String networkName, String networkMac) {
    String password, networkNameSUb;
    if (networkName.length < 8) {
      networkNameSUb = networkName.substring(4, networkName.length - 1);
    } else {
      networkNameSUb = networkName.substring(4, 8);
    }
    password =
        networkMac.replaceAll(RegExp(':'), '').toUpperCase().substring(2, 8) +
            networkNameSUb;
    setState(() {
      wifiNameToConnect = networkName;
      wifiPasswordToConnect = password;
    });
  }

  void checkStateColor(String nameSsid) {
    nameSsid == 'Ubee' ? isGood = true : isGood = false;
    nameSsid == 'Ubee'
        ? textMightAbleToConnect = 'Network  might be able to connect'
        : textMightAbleToConnect = 'Network might not be able to connect';
  }

  void checkConnection() async {
    wifiConfiguration.isWifiEnabled().then((value) {
      print('Is wifi enabled: ${value.toString()}');
    });

    wifiConfiguration.checkConnection().then((value) {
      print('Value: ${value.toString()}');
    });

    WifiConnectionObject wifiConnectionObject =
        await wifiConfiguration.connectedToWifi();
    if (wifiConnectionObject != null) {
      getWifiList();
    }
  }

  Future<void> getWifiList() async {
    wifiNetworkList = await wifiConfiguration.getWifiList();
    print('Network list lenght: ${wifiNetworkList.length.toString()}');
    setState(() {});
  }

  Future<Null> connection() async {
    Wifi.connection(wifiNameToConnect, wifiPasswordToConnect).then((v) {
      print(v);
    });
  }
  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 3));
    checkConnection();
    return null;
  }
}
