import 'dart:async';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:flutter/services.dart';

class dataNetwork {
  WiFiInfoWrapper _wifiObject;
  dataNetwork() {
    scanWiFi();
  }
  Future<WiFiInfoWrapper> scanWiFi() async {
    WiFiInfoWrapper wifiObject;

    try {
      wifiObject = await WiFiHunter.huntRequest;
    } on PlatformException {}

    return wifiObject;
  }

  Future<void> scanHandler() async {
    _wifiObject = await scanWiFi();
    print("WiFi Results (SSIDs) : ");
    for (var i = 0; i < _wifiObject.ssids.length; i++) {
      print("- " + _wifiObject.ssids[i]);
      print("-" + _wifiObject.bssids[i]);
    }
  }

  List getListSsid() {
    return _wifiObject.ssids;
  }

  List getListBssid() {
    return _wifiObject.bssids;
  }
}
