import 'package:app/HomeBottomBar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Used for removing back buttoon.
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text('Settings'),
        ),
      ),
      body: Text("Name......."),
    );
  }
}