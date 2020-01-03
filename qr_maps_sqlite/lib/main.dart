import 'package:flutter/material.dart';
import 'package:qr_maps_sqlite/src/pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR',
      initialRoute: 'home',
      routes: {
        'home':(BuildContext context)=>HomePage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}


