import 'package:app/DealsWidget.dart';
import 'package:app/ItemPage2.dart';
import 'package:app/ItemPage3.dart';
import 'package:app/ItemPage4.dart';
import 'package:app/ItemsWidget.dart';
import 'package:app/SearchPage.dart';
import 'package:app/videoPage.dart';
import 'package:flutter/material.dart';
import 'package:app/CartPage.dart';
import 'package:app/FavouritePage.dart';
import 'package:app/NotificationPage.dart';
import 'package:app/PreviousPage.dart';
import 'package:app/ProfilePage.dart';
import 'package:app/SettingPage.dart';
import 'package:app/SplashPage.dart';
import 'package:app/login_page.dart';
import 'package:app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';
import 'ItemPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'aboutuspage.dart';

class HomePage extends StatefulWidget {
  final bool isLoggedIn;
  late String name, email;

  HomePage({super.key, required this.isLoggedIn, required this.email, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WebViewController controller;
  TextEditingController editingController = TextEditingController();
  List<String> items = [];
  List<String> main_list = [
    "Partial Payment",
    "Stripe Payment",
    "Subscription & Recurring",
    "Barcode Extension",
    "Personalized Products"
  ];

  late String storedValue;
  @override
  void initState() {
    items = main_list;
    super.initState();

    retrieveData();
    setState(() {
      thecallfunction();
    });
  }

  Future<void> thecallfunction() async{
    setState(() {

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getnumber = await prefs.getString('number');
    print("=getnumbevvvvv "+getnumber.toString());
  }
  /*void updateList(String value) {
    setState(() {
      items = main_list
          .where(
              (element) => element.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }*/
  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        items = main_list;
      } else {
        items = main_list
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> retrieveData() async {
    print("#######");
    final sharedPref = await SharedPreferences.getInstance();
    var favourite = sharedPref.getBool("favourite");
    widget.email = sharedPref.getString("email")!;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage(number:1,isLoggedIn: widget.isLoggedIn, email: widget.email, ),),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Milople"),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(number:1,isLoggedIn: widget.isLoggedIn, email: widget.email, ),),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/thumbnails/009/734/564/small/default-avatar-profile-icon-of-social-media-user-vector.jpg'),
                  ),
                  accountName: Text(/*'${widget.name}'*/ "Welcome....."),
                  accountEmail: Text(widget.email.toString()),
                ),
              ),
              if (widget.isLoggedIn) // Show Logout ListTile when logged in
                ListTile(
                  leading: Icon(Icons.accessibility),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage(username: widget.email)),

                    );
                  },
                ),
              if (!widget.isLoggedIn) // Show Login ListTile when not logged in
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: "")),
                    );
                  },
                ),
              /*ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(isLoggedIn: isLoggedIn,email : emailText.text,name : password.text)),
                  );
                },
              ),*/

              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Past Orders'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreviousPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavouritePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.add_alert),
                title: Text('Notifications'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.video_camera_back_outlined),
                title: Text('Video'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPlayerScreen()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.add_call),
                title: Text('About us'),
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsPage(
                        url: 'http://150.107.238.224/zaki/new/bansal245/pub/media-page#events', // Replace with the actual URL
                      ),
                    ),
                  );
                },
              ),

              if (widget.isLoggedIn) // Show Logout ListTile when logged in
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Are you sure you want to exit?"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                var sharedPref =
                                await SharedPreferences.getInstance();
                                sharedPref.setBool(
                                    SplashPageState.KEYLOGIN, false);
                                // Clear the favorite data list
                                await sharedPref.remove('favoriteDataList');
                                // Clear the cart data list
                                await sharedPref.remove('CartDataList');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(title: 'Flutter Demo'),
                                  ),
                                );
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
                ),
              SizedBox(height: 25,),

              Container(
                height: 30,
                child: Row(
                  children: [
                    SizedBox(width: 30,),
                    InkWell(
                      child: Icon(FontAwesomeIcons.linkedinIn,size: 30),
                      onTap:  () => launchUrl(
                        Uri.parse('https://www.linkedin.com/company/milople/'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    SizedBox(width: 25,),
                    InkWell(
                      child: Icon(FontAwesomeIcons.youtube,size: 30),
                      onTap:  () => launchUrl(
                        Uri.parse('https://www.youtube.com/@MilopleInc'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    SizedBox(width: 25,),
                    InkWell(
                      child: Icon(FontAwesomeIcons.facebook,size: 30),
                      onTap:  () => launchUrl(
                        Uri.parse('https://www.facebook.com/Milople/'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    SizedBox(width: 25,),
                    InkWell(
                      child: Icon(FontAwesomeIcons.instagram,size: 30),
                      onTap:  () => launchUrl(
                        Uri.parse('https://www.instagram.com/milople/'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    SizedBox(width: 25,),
                    InkWell(
                      child: Icon(FontAwesomeIcons.locationPin,size: 30),
                      onTap:  () => launchUrl(
                        Uri.parse('https://www.google.com/maps/place/Rangoli+The+Delicacy+Restaurant/@21.7606783,72.1534604,15z/data=!3m1!5s0x395f5a799942ed2b:0xacbc7f8f5a5969e5!4m6!3m5!1s0x395f5a799954d1eb:0x2be7e042bc8a9f4a!8m2!3d21.7623445!4d72.1461949!16s%2Fg%2F124srx3f0?entry=ttu'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            /*Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.sort,
                        size: 30,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () {
                        // Handle sort icon pressed
                        Scaffold.of(context).openDrawer(); // Open the side navigation drawer
                      },
                    ),
                Padding(padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Milople",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey
                  ),
                ),
                ),
                Spacer(),
                Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.blueGrey,
                ),*/ /**/ /*

              ],
            ),
      ),*/
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
              ),
              child: Column(
                children: [
                  /*Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(title: ''),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 5),
                            height: 50,
                            width: 300,
                            child: TextField(
                              onChanged: (value) => filterSearchResults(value),
                              controller: editingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search here....",
                              ),
                            ),

                          ),
                        ),
                        Spacer(),
                        Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xFF475269),
                      ),
                      ],
                    ),
                  ),
                  Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Best Deal of the day..",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7466),
                  ),
                  ),
                ),*/
                  DealsWidget(),
                  // latest launched
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, bottom: 1),
                    child: const Text(
                      "Latest Launched ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                  // latest launched images
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemPage(email: widget.email.toString(),isLoggedIn: widget.isLoggedIn),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 6,
                              shadowColor: Colors.blueGrey,
                              child: Image.asset("assets/images/deal1.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemPage2(),
                                ),
                              );},
                            child: Card(
                              color: Colors.white,
                              elevation: 6,
                              shadowColor: Colors.blueGrey,
                              child: Image.asset("assets/images/deal2.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemPage3(),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 6,
                              shadowColor: Colors.blueGrey,
                              child: Image.asset("assets/images/deal3.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemPage4(),
                                ),
                              );},
                            child: Card(
                              color: Colors.white,
                              elevation: 6,
                              shadowColor: Colors.blueGrey,
                              child: Image.asset("assets/images/deal4.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, bottom: 5),
                    child: const Text(
                      " Available Products",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                  Itemswidget(items:items,email: widget.email.toString(),isLoggedIn: widget.isLoggedIn),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(title: '',email: widget.email.toString(),isLoggedIn: widget.isLoggedIn),
            ),
          );
        },
        child: Icon(Icons.search),),
      ),
    );
  }
}

