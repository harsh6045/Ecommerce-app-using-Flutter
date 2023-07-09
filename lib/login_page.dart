import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/HomePage.dart';
import 'package:app/Intropage.dart';
import 'package:app/SplashPage.dart';
import 'package:app/data.dart';
import 'package:app/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailText = TextEditingController();
  var password = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<data>? dataList;
  int count = 0;
  bool isPasswordVisible = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<String?> getEmailFromGoogleSignIn() async {
    final UserCredential userCredential = await signInWithGoogle();
    final User? user = userCredential.user;
    print("email from google $user.email");
    print("email from google "+user!.email.toString());


    if (user != null) {
      return user.email;

    } else {
      // Handle the case when user is null (failed sign-in)
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  void _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomePage(isLoggedIn: true,email : emailText.text,name : password.text),));
        print('Logged in with Google: ${googleUser.email}');
      }
    } catch (error) {
      print('Error logging in with Google: $error');
    }
  }

  Future login(BuildContext context) async{
    var url = Uri.parse("http://192.168.0.166/database/php.php");
    var response = await http.post(url, body: {
      "username" : emailText.text,
      "password" : password.text,
    });
    var data = json.decode(response.body);
    print("DATAAA"+data.toString());
    if(data == "success" && emailText.text != "" && password.text != ""){

      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(SplashPageState.KEYLOGIN,true);
      sharedPref.setString("email",emailText.text);
      sharedPref.setString("passWord",password.text);
      bool isLoggedin = true;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomePage(isLoggedIn: true,email : emailText.text,name : password.text),));
    }
    else{
      print("ELSEEE");
      Fluttertoast.showToast(msg: "Invalid Username or Password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.red,);
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(SplashPageState.KEYLOGIN, false);

      /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Please enter a valid username and password "),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );*/
    }
  }
  @override

  @override
  Widget build(BuildContext context) {
    if(dataList == null){
      dataList = <data>[];
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Used for removing back buttoon.
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text('Milople'),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg5.jpg'),
                fit: BoxFit.fitWidth,

              )
          ),
          child: Center(
            child: Container(
              height: 470,
              width: 350,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Login",style: TextStyle(fontSize:25,fontWeight: FontWeight.w600),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 200),
                      child: Text("Username :",style: TextStyle(fontSize:20),),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailText,
                          decoration: InputDecoration(
                            hintText: 'Enter email address',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.accessibility, color: Colors.grey),
                              onPressed: (){
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 200),
                      child: Text("Password :",style: TextStyle(fontSize:20),),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: password,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),


                    ElevatedButton(child : Text("Click here to login!"), onPressed :() {
                      login(context);
                    }),
                    ElevatedButton(
                      onPressed: () async {
                        await signInWithGoogle();
                        String? email = await getEmailFromGoogleSignIn();
                        if (email != null) {
                          // Do something with the email
                          print('Logged in with email: $email');
                        } else {
                          // Handle the case when email is null (failed sign-in)
                          print('Failed to retrieve email');
                        }
                      },

                      child: Text('Login with Google'),
                    ),
                    TextButton(onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  IntroPage(),));
                    }
                        , child: Text("Didn't have account sign up"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}