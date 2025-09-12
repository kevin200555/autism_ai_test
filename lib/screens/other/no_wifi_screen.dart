import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WiFiGate extends StatefulWidget {
  final Widget child; // your main app
  const WiFiGate({super.key, required this.child});

  @override
  State<WiFiGate> createState() => _WiFiGateState();
}

class _WiFiGateState extends State<WiFiGate> {
  bool _internetAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    Connectivity().onConnectivityChanged.listen((_) {
      _checkInternet();
    });
  }

  Future<void> _checkInternet() async {
    // First, check if device has a network connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() => _internetAvailable = false);
      return;
    }

    // Then, try to ping an actual website to verify internet access
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() => _internetAvailable = true);
      } else {
        setState(() => _internetAvailable = false);
      }
    } catch (_) {
      setState(() => _internetAvailable = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_internetAvailable) {
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
                  'No internet connection.\nPlease connect to Wi-Fi or cellular data to use this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkInternet,
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
} // EOF no_wifi_screen.dart
