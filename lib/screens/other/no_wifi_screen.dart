import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


// uploading to firebase requires wifi connection
// therefore this widget checks for wifi connection
// and if not connected, it shows a screen asking the user to connect to wifi
// before proceeding to the main app
// it uses the connectivity_plus package to check for wifi connection
class WiFiGate extends StatefulWidget {
  final Widget child; // your main app
  const WiFiGate({super.key, required this.child});

  @override
  State<WiFiGate> createState() => _WiFiGateState();
}

class _WiFiGateState extends State<WiFiGate> {
  bool _wifiConnected = false;

  @override
  void initState() {
    super.initState();
    _checkWifi();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() => _wifiConnected = result == ConnectivityResult.wifi || result == ConnectivityResult.mobile);
    });
  }

  Future<void> _checkWifi() async {
    var result = await Connectivity().checkConnectivity();
    setState(() => _wifiConnected = result == ConnectivityResult.wifi || result == ConnectivityResult.mobile);
  }

  @override
  Widget build(BuildContext context) {
    if (_wifiConnected) {
      return widget.child; // proceed to main app
    } else {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 60, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Please connect to Wi-Fi to use this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkWifi,
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
} // EOF noWiFI_screen.dart
