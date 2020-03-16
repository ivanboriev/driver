import 'package:driver/screens/login.dart';
import 'package:driver/screens/rt1.dart';
import 'package:driver/screens/transportRegisterTypes/truck.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TiD',
      home: Truck(),
    );
  }
}
