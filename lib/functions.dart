import 'package:wifi_configuration_2/wifi_configuration_2.dart';



enum wayToConnectWifi { connectedAutomatically, connectedManually }
 class WifiBrain{

   WifiConfiguration wifiConfiguration = WifiConfiguration();
   List<WifiNetwork> wifiNetworkList = List();
   String valueTextDialog1 = ' ',
       valueTextDialog2 = ' ',
       valueAnimation = '1';
   String NetWorkName, Paswword;
   Future<void> getWifiList() async {
     WifiConnectionObject wifiConnectionObject =
     await wifiConfiguration.connectedToWifi();


     if (wifiConnectionObject != null) {
       wifiNetworkList = await wifiConfiguration.getWifiList();
     }
   }
   bool isWell (String nameSsid){
      return nameSsid == 'Ubee' ?  true :  false;
   }
   String textMightBeAbleToConnect(String nameSsid){

     return nameSsid == 'Ubee'
         ? 'Network  might be able to connect'
         : 'Network might not be able to connect';

   }
   setValuesToConnect(String networkName, String networkMac, wayToConnectWifi wayTo,  ){
     String password, networkNameSUb;
     //wayTo == wayToConnect.connectedAutomatically
     if ( wayTo == wayToConnectWifi.connectedAutomatically) {

       if (networkName.length < 8) {
         networkNameSUb = networkName.substring(4, networkName.length - 1);
       } else {
         networkNameSUb = networkName.substring(4, 8);
       }
       password =
           networkMac.replaceAll(RegExp(':'), '').toUpperCase().substring(2, 8) +
               networkNameSUb;
     }
     NetWorkName =networkName;
     Paswword =password;

   }
   Future <void> getConnectionState(String wifiName, String wifiPassword) async {
     WifiConnectionStatus connectionStatus = await wifiConfiguration
         .connectToWifi(wifiName, wifiPassword, "wifi_configuration_2.dart");

     switch (connectionStatus) {
       case WifiConnectionStatus.connected:
         valueTextDialog1 = 'Connected';
         valueTextDialog2 = 'Successfully Connected';
         valueAnimation = '1';
         print('connected eh');
         break;

       case WifiConnectionStatus.profileAlreadyInstalled:

         break;
       case WifiConnectionStatus.locationNotAllowed:
         break;
       case WifiConnectionStatus.alreadyConnected:
         print('already connected ');
         break;
       case WifiConnectionStatus.notConnected:
         valueTextDialog1 = 'Failed';
         valueTextDialog2 = 'Password incorrect or was changed by the owner';
         valueAnimation = '2';
         print('Not connected eh');
         break;
     }
//     showAlertDialog(
//         context, _valueTextDialog1, _valueTextDialog2, _valueAnimation);
   }


 }