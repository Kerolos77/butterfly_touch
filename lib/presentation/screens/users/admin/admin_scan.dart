import 'package:flutter/material.dart';

import '../../../widgets/global/default_text/default_text.dart';

class AdminScan extends StatefulWidget {
  const AdminScan({super.key});

  @override
  State<AdminScan> createState() => _AdminScanState();
}

class _AdminScanState extends State<AdminScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: defaultText(text: 'Scan'),
      ),
    );
  }
}
