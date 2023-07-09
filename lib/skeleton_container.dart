import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'ItemPage.dart';

class skeleton_container extends StatelessWidget {

  late String name, email;
  final bool isLoggedIn;
  skeleton_container({required this.isLoggedIn, required this.email,});
  // root of the application
  @override
  Widget build(BuildContext context) {
      // Define the timer function
      void navigateToItemPage() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemPage(email: email.toString(),isLoggedIn: isLoggedIn)),
        );
      }

      // Use Timer to delay the navigation
      Timer(Duration(seconds: 1), navigateToItemPage);
    return MaterialApp(
      title: 'Product',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Product"),
          backgroundColor: Colors.blueGrey,
        ),
        // list of items in body
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SkeletonAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 10),
                                child: SkeletonAnimation(
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 10),
                                child: SkeletonAnimation(
                                  child: Container(
                                    height: 20,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 10),
                                child: SkeletonAnimation(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: SkeletonAnimation(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SkeletonAnimation(
                        child: Container(
                          width: 350,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10.0),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30, bottom: 10,left: 20),
                                      child: SkeletonAnimation(
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(width: 20,),
                          Container(
                            height: 100,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                                      child: SkeletonAnimation(
                                        child: Container(
                                          height: 50,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            }),
      ),
    );
  }
}