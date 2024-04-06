import 'package:api_project/splace.dart';
import 'package:flutter/material.dart';

import 'addData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: const splace(),
    );
  }
}