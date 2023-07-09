import 'dart:typed_data';
import 'package:app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skeletons/skeletons.dart';
import 'CartPage.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:just_audio/just_audio.dart';

class ItemPage extends StatefulWidget {

  late String name, email;
  final bool isLoggedIn;
  ItemPage({required this.isLoggedIn, required this.email,});

  int index = 1;
  //ItemPage({required this.index});
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class MyController extends GetxController{
    var number = 1.obs;
    //var number2 = 0.obs;
    final String numberKey = 'number';
    //final String numberKey2 = 'number';


    @override
    void onInit() {
      super.onInit();
      loadNumberFromPreferences();
    }

    increment(){
      number.value++;
      saveNumberToPreferences();
    }
    decrement(){
      if(number.value<=0){
        Fluttertoast.showToast(
            msg: "Number should be greater than zero",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.redAccent
        );
      }
      else{
        number.value--;
        saveNumberToPreferences();
      }
    }
    Future<void> saveNumberToPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(numberKey, number.value.toString());
      print("DATA&&&&&&&&&&&"+number.value.toString());
      print("numberKeyccccccccccccccccccc " +number.toString());
      getfunctions();
    }

    Future<void> getfunctions() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var getnumber = await prefs.getString('number');
      print("numberKeyaaaaaaaaa " +getnumber.toString());

    }

    Future<void> loadNumberFromPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? savedNumber = prefs.getInt(numberKey)!;
      if (savedNumber != null) {
        number.value = savedNumber;
      }
    }
}

class _ItemPageState extends State<ItemPage> {

  final MyController c = Get.put(MyController());
  bool isAdded = false;
  bool isAddedcart = false;
  List<int> favoriteDataList = [];
  List<int> CartDataList = [];
  double rating = 3.5;


  int getTextValue(double rating) {
    if (rating == 1) {
      return 1;
    } else if (rating == 2) {
      return 2;
    } else if (rating == 3) {
      return 3;
    } else if (rating == 4) {
      return 4;
    } else if (rating == 5) {
      return 5;
    } else {
      return 0;
    }
  }


  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/audio1.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {

      ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
      audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List

      player.onDurationChanged.listen((Duration d) { //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {

        });
      });

      player.onAudioPositionChanged.listen((Duration  p){
        currentpos = p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds:currentpos).inHours;
        int sminutes = Duration(milliseconds:currentpos).inMinutes;
        int sseconds = Duration(milliseconds:currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });

    });
    super.initState();
    //retrieveData();
    checkFavoriteStatus();
    checkCartStatus();
    loadRatingFromPreferences();
  }

  Future<void> saveRatingToPreferences(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating', rating);
  }

  Future<void> loadRatingFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedRating = prefs.getDouble('rating');
    if (savedRating != null) {
      setState(() {
        rating = savedRating;
      });
    }
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
      favoriteDataList = (sharedPref.getStringList('favoriteDataList') ?? [])
          .map(int.parse)
          .toList();
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

    sharedPref.setStringList(
        'favoriteDataList', favoriteDataList.map((e) => e.toString()).toList());
    sharedPref.setBool('isAdded${widget.index}', isAdded);
    print("Favorite List: $favoriteDataList");
  }

  /*void playAudio() async {
    final player = AudioPlayer();
    await player.play('assets/audio/audio1.mp3');
    await player.play();                            // Play while waiting for completion
    await player.pause();                           // Pause but remain ready to play
    await player.seek(Duration(seconds: 10));        // Jump to the 10 second position
    await player.setSpeed(2.0);                     // Twice as fast
    await player.setVolume(0.5);                    // Half as loud
    await player.stop();
  }*/

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

  /*Future<void> retrieveData() async {
    final sharedPref = await SharedPreferences.getInstance();
    var isloggedin = sharedPref.getBool("KEYLOGIN");
    widget.email = sharedPref.getString("email")!;
  }*/

  /*void increaseQuantity() {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
        Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        child: Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage(isLoggedIn: widget.isLoggedIn, email: widget.email, name: '')),

                );              },
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
                    MaterialPageRoute(builder: (context) => CartPage(number: c.number.value,isLoggedIn: widget.isLoggedIn, email: widget.email,)));
              },
              child: const Icon(Icons.shopping_cart_sharp,
                size: 23,color: Colors.white,),
            )
          ],
        ),
      ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              "assets/images/deal1.png",
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
                          "Partial Payment",
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
                   // Replace with the actual initial rating value
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 25,
                    itemBuilder: (context, index) {
                      IconData starIcon = Icons.star;
                      Color starColor;

                      if (rating >= 1) {
                        if (rating <= 2) {
                          starColor = Colors.red;
                        } else if (rating <= 3) {
                          starColor = Colors.orange;
                        } else if (rating <= 4) {
                          starColor = Colors.yellow;
                        } else {
                          starColor = Colors.green;
                        }
                      } else {
                        starColor = Colors.grey;
                      }

                      return Icon(starIcon, color: starColor);
                    },
                    onRatingUpdate: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                      saveRatingToPreferences(newRating);
                    },
                  ),


                      SizedBox(width: 5),
                      Text("(${getTextValue(rating)})"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 300, top: 10),
                    child: Text(
                      "\$72",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 100,),
                      Container(
                          margin: EdgeInsets.only(top:5),
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Wrap(
                              spacing: 10,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      if(!isplaying && !audioplayed){
                                        int result = await player.playBytes(audiobytes);
                                        if(result == 1){ //play success
                                          setState(() {
                                            isplaying = true;
                                            audioplayed = true;
                                          });
                                        }else{
                                          print("Error while playing audio.");
                                        }
                                      }else if(audioplayed && !isplaying){
                                        int result = await player.resume();
                                        if(result == 1){ //resume success
                                          setState(() {
                                            isplaying = true;
                                            audioplayed = true;
                                          });
                                        }else{
                                          print("Error on resume audio.");
                                        }
                                      }else{
                                        int result = await player.pause();
                                        if(result == 1){ //pause success
                                          setState(() {
                                            isplaying = false;
                                          });
                                        }else{
                                          print("Error on pause audio.");
                                        }
                                      }
                                    },
                                    icon: Icon(isplaying?Icons.pause:Icons.play_arrow),
                                    label:Text(isplaying?"Pause":"Play")
                                ),

                              ],
                            ),
                          )

                      )
                    ],
                  ),
                  const Text(
                    "The Magento 2 Partial Payment Extension for Magento 2 by Milople helps you sell products and services in installments, EMI, and layaway plans. The customer can place an order with a down payment and pay the remaining amount in one or multiple installments.",
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
                       // onTap: ()=> c.decrement(),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orangeAccent,
                          ),
                          child: Icon(Icons.remove, size: 20),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Obx(() => Text("${c.number.toString()}",style: const TextStyle(
                        fontSize: 25,
                      ),)),
                      SizedBox(width: 10,),
                      /*Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.quantity.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),*/
                      InkWell(
                        //onTap: ()=> c.increment(),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
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
