import 'package:butterfly_touch/presentation/screens/regisation_screen.dart';
import 'package:butterfly_touch/presentation/screens/users/admin/admin_scan.dart';
import 'package:butterfly_touch/presentation/screens/users/user/user_home.dart';
import 'package:flutter/material.dart';

import '../../constants/conestant.dart';
import '../widgets/global/logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashtime = 0;

  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        Widget widget;
        if (constUid != null && constUid != '') {
          constUid = constUid;
          if (constUid == 'admin') {
            widget = const AdminScan();
          } else {
            widget = const UserHome();
          }
        } else {
          widget = Registration();
        }
        return widget;
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: logo(size: 150)),
    );
  }
}
