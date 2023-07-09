import 'package:app/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemPage3 extends StatefulWidget {
  int index = 3;
  int quantity = 1;

  //ItemPage3({required this.index});
  @override
  State<ItemPage3> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage3> {
  bool isAdded = false;
  bool isAddedcart = false;
  List<int> favoriteDataList = [];
  List<int> CartDataList = [];

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
    checkCartStatus();
  }

  void checkCartStatus() async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isAddedcart = sharedPref.getBool('isAdded${widget.index}') ?? false;
      CartDataList = (sharedPref.getStringList('CartDataList') ?? [])
          .map(int.parse)
          .toList();
    });
  }

  void checkFavoriteStatus() async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isAdded = sharedPref.getBool('isAdded${widget.index}') ?? false;
      favoriteDataList = (sharedPref.getStringList('favoriteDataList') ?? []).map(int.parse).toList();
    });
  }

  void toggleFavorite() async {
    setState(() {
      isAdded = !isAdded;
    });

    var sharedPref = await SharedPreferences.getInstance();
    if (isAdded) {
      favoriteDataList.add(widget.index);
    } else {
      favoriteDataList.remove(widget.index);
    }

    sharedPref.setStringList('favoriteDataList', favoriteDataList.map((e) => e.toString()).toList());
    sharedPref.setBool('isAdded${widget.index}', isAdded);
    print("Favorite List: $favoriteDataList");
  }


  void toggleCart() async {
    /*setState(() {
      isAddedcart = !isAddedcart;
    });*/

    var sharedPref = await SharedPreferences.getInstance();
    if (isAddedcart) {
      CartDataList.add(widget.index);
    } else {
      CartDataList.remove(widget.index);
    }

    sharedPref.setStringList(
        'CartDataList', CartDataList.map((e) => e.toString()).toList());
    sharedPref.setBool('isAddedcart${widget.index}', isAddedcart);
    print("Cart List: $CartDataList");
  }
  void increaseQuantity() {
    setState(() {
      widget.quantity++;
    });
  }

  void decreaseQuantity() {
    if (widget.quantity > 1) {
      setState(() {
        widget.quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          /*Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                    size: 25,color: Colors.white,),
                ),
                Padding(padding: EdgeInsets.only(left: 18),
                  child: Text("Product",
                    style: TextStyle(
                        fontSize: 23,color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: const Icon(Icons.shopping_cart_sharp,
                    size: 23,color: Colors.white,),
                )
              ],
            ),
          ),*/
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              "assets/images/deal3.png",
              height: 300,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Subscription & Recurring",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 3.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: 5),
                      Text("(450)"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 280, top: 10),
                    child: Text(
                      "\$264",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "This Magento 2 extension drives the highest customer loyalty, repeat business, and flow of revenue. Magento 2 Recurring payment extension by Milople helps you to sell your products and services with rental, recurring, membership, and plans for subscriptions payments on your Magento store.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: decreaseQuantity,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent,
                            ),
                            child: Icon(Icons.remove, size: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: increaseQuantity,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent,
                            ),
                            child: Icon(Icons.add, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            CartDataList.contains(widget.index)
                                ? Fluttertoast.showToast(
                              msg: "Already added to the cart",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.green,
                            )
                                : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content:
                                  const Text("Add this to cart ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Fluttertoast.showToast(
                                          msg: "Added to Cart",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.green,
                                        );
                                        setState(() {
                                          isAddedcart = true;
                                        });
                                        toggleCart();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 65,
                            width: 250,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Row(
                              children: [
                                if (CartDataList.contains(widget.index))
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Added",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                else
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                if (CartDataList.contains(widget.index))
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          height: 65,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFD4ECF7),
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: InkWell(
                            onTap: () {
                              toggleFavorite();
                            },
                            child: Icon(
                              favoriteDataList.contains(widget.index)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
