import 'dart:async';

import 'package:app/ItemPage.dart';
import 'package:app/ItemPage2.dart';
import 'package:app/ItemPage3.dart';
import 'package:app/ItemPage4.dart';
import 'package:app/ItemPage5.dart';
import 'package:flutter/material.dart';
import 'package:app/skeleton_container.dart';

class Itemswidget extends StatelessWidget {
  final List<String> items;
  late String name, email;
  final bool isLoggedIn;

  List<int> maindatalist = List<int>.generate(6, (index) => index + 1);
  Itemswidget({required this.items,required this.isLoggedIn, required this.email,});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.72,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    int index = maindatalist.length;
                    print("current"+index.toString());
                    print("III" + index.toString());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => skeleton_container(email: email.toString(),isLoggedIn: isLoggedIn)),
                    );

                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/deal1.png",
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Partial Payment ",
                      style:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "For M2",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "\$72",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.redAccent,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Color(0xFF475269),
                        iconSize: 28,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  int index = maindatalist.length;
                  print("current"+index.toString());
                  print("III" + index.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPage2()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/deal2.png",
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Stripe Payment",
                    style:
                    TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "\$55",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Color(0xFF475269),
                      iconSize: 28,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  int index = maindatalist.length;
                  print("current"+index.toString());
                  print("III" + index.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPage3()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/deal3.png",
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Subscription & Recurring",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "\$264",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Color(0xFF475269),
                      iconSize: 25,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  int index = maindatalist.length;
                  print("current"+index.toString());
                  print("III" + index.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPage4()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/deal4.png",
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Barcode Extension",
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "\$79",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Color(0xFF475269),
                      iconSize: 25,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  int index = maindatalist.length;
                  print("current"+index.toString());
                  print("III" + index.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPage5()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/deal5.png",
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Personalized Products",
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "\$102",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.redAccent,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Color(0xFF475269),
                      iconSize: 25,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}
