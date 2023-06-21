import 'package:butterfly_touch/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'constants/conestant.dart';
import 'data/firecase/firebase_reposatory.dart';
import 'data/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();
  await CacheHelper.init();
  constUid = CacheHelper.getData(key: 'user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  SplashScreen(),
    );
  }
}
