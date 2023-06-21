import 'package:flutter/material.dart';
import '../../../widgets/global/default_text/default_text.dart';

class UserScan extends StatefulWidget {
  const UserScan({super.key});

  @override
  State<UserScan> createState() => _UserScanState();
}

class _UserScanState extends State<UserScan> {
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
