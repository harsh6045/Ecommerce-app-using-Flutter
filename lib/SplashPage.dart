import 'dart:async';

import 'package:app/HomePage.dart';
import 'package:app/login_page.dart';
import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget{
  late String name, email;
  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    retrieveData();
    setState(() {
      whereToGo();
    });
  }

  Future<void> retrieveData() async {
    print("#######");
    final sharedPref = await SharedPreferences.getInstance();
    var favourite = sharedPref.getBool("favourite");
    widget.email = sharedPref.getString("email")!;
  }

   whereToGo() async {
    final sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    setState(() {
    });
    Timer(Duration(seconds: 3), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: true,email : widget.email.toString(),name : "")),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: false,email : "",name : "")),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: false,email : "",name : "")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center(
          child: Container(
              height: 300,
              width: 300,
              color: Colors.blue[700],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Milople', style: TextStyle(fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[50]),),
                    Image.asset("assets/images/logo1.png"),
                  ]
              )
          ),
        )
    );
  }
}
