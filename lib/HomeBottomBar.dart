/*
import 'package:app/CartPage.dart';
import 'package:app/FavouritePage.dart';
import 'package:app/HomePage.dart';
import 'package:app/ProfilePage.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 32,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 32,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FavouritePage()));
            },
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 32,
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Icon(
              Icons.shopping_cart_sharp,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
*/
