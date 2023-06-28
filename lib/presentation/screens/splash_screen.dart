import 'package:flutter/material.dart';

import '../../constants/conestant.dart';
import '../../presentation/screens/regisation_screen.dart';
import '../../presentation/screens/users/admin/admin_home.dart';
import '../../presentation/screens/users/user/user_home.dart';
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
            widget = const AdminHome();
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
