import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

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
  String _valueTextDialog1 = ' ', _valueTextDialog2 =' ', _valueAnimation ='1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wifiConfiguration = WifiConfiguration();
    _checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: listCenter(),
    );
  }

  RefreshIndicator listCenter() {
    return RefreshIndicator(
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
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Icon(
                            _isGood ? Icons.network_wifi : Icons.wifi_lock,
                            color: _isGood ? Colors.green : Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
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
                                _textMightAbleToConnect,
                                style: TextStyle(
                                    color: _isGood ? Colors.green : Colors.red,
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
                          _setValuesToConnect(
                              wifiNetwork.ssid, wifiNetwork.bssid);

                         getConnectionState();
                        },
                        textColor: Colors.white,
                        color: Color(0xff255152),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        splashColor: _isGood ? Colors.green : Colors.red,
                        animationDuration: Duration(seconds: 2),
                        child: Text(
                          'Connect',
                          style: TextStyle(fontSize: 20, fontFamily: 'Bitter'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }


  void getConnectionState() async {
    WifiConnectionStatus connectionStatus =
    await wifiConfiguration.connectToWifi(_wifiNameToConnect,_wifiPasswordToConnect,"wifi_configuration_2.dart");

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
        )
    );
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

  void _checkConnection() async {

    WifiConnectionObject wifiConnectionObject =
    await wifiConfiguration.connectedToWifi();
    if (wifiConnectionObject != null) {
      _getWifiList();
    }
  }

  Future<void> _getWifiList() async {
    var _wifiNetworkListLocal;
    _wifiNetworkListLocal = await wifiConfiguration.getWifiList();
    setState(() {
      _wifiNetworkList = _wifiNetworkListLocal;
    });
  }


  Future<Null> _refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    _checkConnection();
    return null;
  }
}
