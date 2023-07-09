import 'package:app/ItemPage.dart';
import 'package:app/PaymentPage.dart';
import 'package:app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class CartPage extends StatefulWidget {
  final int number;

  late String name, email;
  final bool isLoggedIn;

  CartPage({
    required this.number,
    required this.isLoggedIn,
    required this.email,
  });
  final MyController c = Get.put(MyController());
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> CartDataList = [];
  List<String> CartDataListName = [
    "Partial Payment",
    "Stripe Payment",
    "Subscription & Recurring",
    "Barcode Extension",
    "Personalized Products"
  ];
  List<String> ImagesList = [
    "assets/images/deal1.png",
    "assets/images/deal2.png",
    "assets/images/deal3.png",
    "assets/images/deal4.png",
    "assets/images/deal5.png",
  ];
  List<int> PriceList = [72, 55, 264, 79, 102];
  List<int> dropdownValues = [1,1,1,1,1];

  @override
  void initState() {
    super.initState();
    getCartDataList().then((dataList) {
      setState(() {
        CartDataList = dataList;
      });
    });
  }

/*  void increaseQuantity() {
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
  }*/

  @override
  Widget build(BuildContext context) {
    int CalculateTotal(List<int> PriceList, List<int> dropdownValues)
    {
      int total = 0;
      int length = CartDataList.length;

      for (int i = 0; i < length; i++)
      {
        int totalPrice = PriceList[i] * dropdownValues[i];
        total += totalPrice;
      }

      return total;
    }
    // Variable to store the total value of all items

    // Calculate the total value
    /*for (var item in CartDataList) {
      total += PriceList[item - 1];
    }*/

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                      isLoggedIn: widget.isLoggedIn,
                      email: widget.email,
                      name: '')),
            );
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: Text("your cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CartDataList.isEmpty
                ? Center(
                    child: Text('No item selected'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.antiAlias,
                    itemCount: CartDataList.length,
                    itemBuilder: (context, index) {
                      var currentItem = CartDataList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.white,
                        elevation: 6,
                        shadowColor: Colors.blueGrey,
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(ImagesList[currentItem - 1]),
                          ),
                          title: Text(
                            CartDataListName[currentItem - 1],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "\$${PriceList[currentItem - 1]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          trailing: Container(
                            height: 30,
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*InkWell(
                                  onTap: decreaseQuantity,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Icon(Icons.remove, size: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    widget.quantity.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                InkWell(
                                  onTap: increaseQuantity,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Icon(Icons.add, size: 15),
                                  ),
                                ),*/

                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text("Qty "),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<int>(
                                    value: dropdownValues[index],
                                    items: [1, 2, 3, 4, 5].map((value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text('$value'),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValues[index] = newValue!;
                                        print(dropdownValues);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 120,
                                            color: Colors.white24,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12, bottom: 8),
                                                    child: Text(
                                                        'Are you sure you want to remove this item.?',
                                                        style: TextStyle(
                                                            fontSize: 17)),
                                                  ),
                                                  Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          child:
                                                              const Text('Yes'),
                                                          onPressed: () {
                                                            setState(() {
                                                              CartDataList
                                                                  .removeAt(
                                                                      index);
                                                              updateCartDataList();
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        ElevatedButton(
                                                          child:
                                                              const Text('No'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            child: Column(
              children: [
                Text("Summary",style: TextStyle(fontSize: 25),),
                SizedBox(height: 20,),
                Text("Total amount:",style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Text("Shipping charges:",style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Text("Tax :",style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Container(
                  width: 300, // Set the desired width for the line
                  child: Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                Text("Total: \$${CalculateTotal(PriceList, dropdownValues).toString()}",style: TextStyle(fontSize: 18),),
              ],
            ),

          ),

          SizedBox(height: 10),
          Container(
            height: 50,
            color: Colors.deepOrangeAccent,
            child: Center(
              child: Text(
                'Total: \$${CalculateTotal(PriceList, dropdownValues).toString()}', // Display the total value
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: InkWell(
          child: Container(
            height: 50,
            child: const Center(
              child: Text(
                'Check Out',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          onTap: () {
            if (widget.isLoggedIn == true) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentPage()),
              );
            } else {
              Fluttertoast.showToast(
                msg: "Login first",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.green,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: '',
                        )),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<int>> getCartDataList() async {
    var sharedPref = await SharedPreferences.getInstance();
    var CartDataList = sharedPref.getStringList('CartDataList') ?? [];
    return CartDataList.map(int.parse).toList();
  }

  Future<void> updateCartDataList() async {
    var sharedPref = await SharedPreferences.getInstance();
    var stringList = CartDataList.map((item) => item.toString()).toList();
    await sharedPref.setStringList('CartDataList', stringList);
  }
}
