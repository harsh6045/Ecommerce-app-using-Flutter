import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/HomePage.dart';
import 'package:app/Intropage.dart';
import 'package:flutter/foundation.dart';
import 'package:app/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:app/data.dart';
import 'package:app/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home:
        SplashPage(),
      /*Center(
        child: Container(
          child: SplashScreen(
              seconds: 5,
              navigateAfterSeconds:HomePage(),
              title: new Text(
                'Milople',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.white),
              ),
              image: new Image.asset('assets/images/logo1.png'),
              photoSize: 100.0,
              backgroundColor: Colors.blue,
              styleTextUnderTheLoader: new TextStyle(),
              loaderColor: Colors.white
          ),
        ),
      ),*/
    );
  }
}