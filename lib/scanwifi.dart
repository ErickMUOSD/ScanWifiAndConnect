import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'constants.dart';
import 'buttonbar.dart';

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
  bool _isGood = false;
  List<WifiNetwork> _wifiNetworkList = List();
  String _textMightAbleToConnect = '';
  String _wifiNameToConnect = '', _wifiPasswordToConnect = '';
  String _valueTextDialog1 = ' ',
      _valueTextDialog2 = ' ',
      _valueAnimation = '1';
  @override
  void initState() {
    super.initState();
    wifiConfiguration = WifiConfiguration();
    _getWifiList();
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
          style: kStyleBssid,
        ),
      ),
      body: widgets(),
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
                _wifiNetworkList.removeRange(0, _wifiNetworkList.length);
              });
              await _refreshList();
            },
            child: ListView.builder(
                itemCount: _wifiNetworkList.length,
                itemBuilder: (context, int index) {
                  WifiNetwork wifiNetwork = _wifiNetworkList[index];
                  _checkStateColor(wifiNetwork.ssid.substring(0, 4));
                  return SafeArea(
                    child: Card(
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
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Icon(
                                  _isGood
                                      ? Icons.network_wifi
                                      : Icons.wifi_lock,
                                  color: _isGood ? kGreenColor : kRedColor,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      wifiNetwork.ssid,
                                      style: kStyleSsid,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      wifiNetwork.bssid,
                                      style: kStyleBssid,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      _textMightAbleToConnect,
                                      style: TextStyle(
                                          color:
                                              _isGood ? kGreenColor : kRedColor,
                                          fontSize: 15.0,
                                          fontFamily: 'Source Sans Pro'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          ButtonBars(
                            onpress: () {
                              _setValuesToConnect(
                                  wifiNetwork.ssid, wifiNetwork.bssid);

                              getConnectionState();
                            },
                            splashcolor: _isGood ? kGreenColor : kRedColor,
                            childs: Text(
                              'Connect',
                              style: kStyleBssid,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  void getConnectionState() async {
    WifiConnectionStatus connectionStatus =
        await wifiConfiguration.connectToWifi(_wifiNameToConnect,
            _wifiPasswordToConnect, "wifi_configuration_2.dart");

    switch (connectionStatus) {
      case WifiConnectionStatus.connected:
        print("connected 1");
        _valueTextDialog1 = 'Connected';
        _valueTextDialog2 = 'Successfully Connected';
        _valueAnimation = '1';
        break;

      case WifiConnectionStatus.alreadyConnected:
        print("alreadyConnected 2 ");
        break;

      case WifiConnectionStatus.notConnected:
        print("notConnected 3");
        _valueTextDialog1 = 'Failed';
        _valueTextDialog2 = 'Password incorrect or was changed by the owner';
        _valueAnimation = '2';
        break;
    }
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                'animations/animation$_valueAnimation.gif',
                fit: BoxFit.cover,
              ),
              title: Text(
                _valueTextDialog1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              description: Text(
                _valueTextDialog2,
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

  void _setValuesToConnect(String networkName, String networkMac) {
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
      _wifiNameToConnect = networkName;
      _wifiPasswordToConnect = password;
    });
  }

  void _checkStateColor(String nameSsid) {
    nameSsid == 'Ubee' ? _isGood = true : _isGood = false;
    nameSsid == 'Ubee'
        ? _textMightAbleToConnect = 'Network  might be able to connect'
        : _textMightAbleToConnect = 'Network might not be able to connect';
  }

  Future<void> _getWifiList() async {
    WifiConnectionObject wifiConnectionObject =
        await wifiConfiguration.connectedToWifi();

    if (wifiConnectionObject != null) {
      var _wifiNetworkListLocal;
      _wifiNetworkListLocal = await wifiConfiguration.getWifiList();
      setState(() {
        _wifiNetworkList = _wifiNetworkListLocal;
      });
    }
  }

  Future<Null> _refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    _getWifiList();
    return null;
  }
}
