import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:images_picker/images_picker.dart';
import 'package:scan/scan.dart';

import 'admin.dart';

class AdminScan extends StatefulWidget {
  const AdminScan({super.key});

  @override
  State<AdminScan> createState() => _AdminScanState();


}

class _AdminScanState extends State<AdminScan> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';
  ScanController controller = ScanController();
  String qrcode1 = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.toggleTorchMode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            Wrap(
              children: [
//               Container(
//                 width: 250, // custom wrap size
//                 height: 250,
//                 child: ScanView(
//                   controller: controller,
// // custom scan area, if set to 1.0, will scan full area
//                   scanAreaScale: .7,
//                   scanLineColor: Colors.green.shade400,
//
//                   onCapture: (data) {
//                     // do something
//                   },
//                 ),
//               ),
                ElevatedButton(
                  child: Text("parse from image"),
                  onPressed: () async {
                    List<Media>? res = await ImagesPicker.openCamera();
                    print('----------------------------- $res');
                    if (res != null) {
                      String? str = await Scan.parse(res[0].path);
                      print('********************************* $str');
                      if (str != null) {
                        setState(() {
                          qrcode = str;
                        });
                      }
                    }
                  },
                ),
                ElevatedButton(
                  child: Text('go scan page'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                          return Admin();
                        }));
                  },
                ),
              ],
            ),
            Text('scan result is $qrcode'),
          ],
        ),
      ),
    );
  }
}
