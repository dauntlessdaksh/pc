import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  MobileScannerController controller = MobileScannerController();
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _onDetect(BarcodeCapture barcode) {
    if (barcode.barcodes.isNotEmpty) {
      final String scannedData = barcode.barcodes.first.rawValue ?? "";
      if (scannedData.isNotEmpty) {
        controller.stop(); // Stop scanning after first scan
        setState(() => isScanning = false);
        _sendToApi(scannedData);
      }
    }
  }

  Future<void> _sendToApi(String scannedData) async {
    final response = await http.post(
      Uri.parse('https://api.programming-club.tech/api/presentQr/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'encrypted_key': scannedData}),
    );
 final responseBody = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      // Handle success
      _showDialog('Success: ${responseBody['message']}');
    } else {
      // Handle error
      _showDialog('Error: ${responseBody['message']}');
    }
  }

  void _showDialog(String response) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("API Response"),
            content: Text(response),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isScanning)
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MobileScanner(
                  controller: controller,
                  onDetect: _onDetect,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isScanning) {
                    controller.stop();
                  } else {
                    controller.start();
                  }
                  isScanning = !isScanning;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isScanning ? Colors.red : Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isScanning ? "Cancel Scanning" : "Start Scanning",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
