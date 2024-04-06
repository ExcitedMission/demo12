import 'dart:async';

import 'package:api_project/addData.dart';
import 'package:api_project/home.dart';
import 'package:api_project/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class splace extends StatefulWidget {
  const splace({super.key});

  @override
  State<splace> createState() => splaceState();
}

class splaceState extends State<splace> {
  static const String KEYLOGIN="login1";
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SafeArea(
        child: Center(
          child: Container(
            width: 150, height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.greenAccent[700]),
            child: Icon(Icons.mood, size: 100,color: Colors.deepOrange[700],),
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(Duration(seconds: 3),(){
      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>homePage()));
        }else{
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>login()));
        }
      }else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>addData()));
      }
    });
  }
}