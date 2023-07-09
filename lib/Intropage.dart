import 'package:app/login_page.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_helper.dart';

class IntroPage extends StatefulWidget{
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  var ufname = TextEditingController();

  var ulname = TextEditingController();

  var mobileno = TextEditingController();

  var emailid = TextEditingController();

  var pass = TextEditingController();

  var conpass = TextEditingController();

  var gender = TextEditingController();

  var age = TextEditingController();

  String selectedGender = '';
  String? _gender;
  void setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

   DateTime? _selectedDate ;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future signup(BuildContext context) async{
    var url = Uri.parse("http://192.168.0.166/database/register.php");
    var response = await http.post(url, body: {
      "username" : emailid.text,
      "password" : pass.text,
      "firstname" :ufname.text,
      "lastname" :ulname.text,
      "mobile" :mobileno.text,
      "age" : age.text,
      "gender" : gender.text,
      "copass" : conpass.text,
    });
    var data = json.decode(response.body);
    print("DATAAA"+data.toString());

    bool isEmail(String text) {
      // Regular expression pattern for email validation
      String pattern =
          r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
      RegExp regex = RegExp(pattern);

      // Check if the text matches the email pattern
      return regex.hasMatch(text);
    }

      if (data == "success" &&
          pass.text == conpass.text && ufname.text != "" && isEmail(emailid.text) &&
          mobileno.text != "" && emailid.text != "" && pass.text != "" &&
          conpass.text != "") {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Flutter Demo')),);
        print("DATAAA" + data.toString());
        Fluttertoast.showToast(msg: "Sign up successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[300],
          textColor: Colors.green,);
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "1.Password & Confirm password didn't match \n2.Fill the * sign places. \n3.Enter a valid email Id"),
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
        );
      }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body:
      SingleChildScrollView(
        child: Container(
            color: Colors.black12,
            child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Center(child: Text("Sign Up",style: TextStyle( fontSize: 25,fontWeight: FontWeight.bold),)),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
                      TextField(
                        //maxLength: 20,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'First Name*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        controller: ufname,
                      )
                  ),

                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Last Name ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        controller: ulname,
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedDate != null
                              ? " ${_selectedDate.toString().substring(0, 10)}"
                              : "  Enter your birth date",
                          style: TextStyle(fontSize: 17,color: Colors.black54),
                        ),
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
                      TextField(
                        //maxLength: 10,
                        decoration: InputDecoration(
                          hintText: 'Mobile No.*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: mobileno,
                      )
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10,bottom: 5,top: 5),
                    child: const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 190,
                        child: RadioListTile(
                          title: Text("Male"),
                          value: "male",
                          groupValue: _gender,
                          onChanged: (value){
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                      ),

                      Container(
                        height: 50,
                        width: 190,
                        child: RadioListTile(
                          title: Text("Female"),
                          value: "female",
                          groupValue: _gender,
                          onChanged: (value){
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                     child:
                     TextField(
                       //maxLength: 3,
                       decoration: InputDecoration(
                         hintText: 'Age in numbers',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: age,
                          ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                        TextField(
                          //maxLength: 50,
                          decoration: InputDecoration(
                              hintText: 'Email address/Username *',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailid,
                        )
                  ),


                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                    TextField(
                      //maxLength: 20,
                      obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password*',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: pass,
                          ),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                    TextField(
                      //maxLength: 20,
                      obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password*',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: conpass,
                          ),

                  ),


              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(child : Text("Click here to signup!"), onPressed :(){
                  String firstname = ufname.text.toString();
                  String lastname = ulname.text;
                  String mobile = mobileno.text;
                  String email = emailid.text;
                  String password = pass.text;
                  String confirm = conpass.text;
                  String gen = gender.text;
                  String uage = age.text;

                  signup(context);
                  print(" firstname : $firstname, lastname : $lastname, mobile : $mobile, email : $email,  password : $password , Gender : $gen, Age : $uage");

                }
                ),
              ),
                  Center(child: Text("* fill them compulsory ",style: TextStyle( fontSize: 10,fontWeight: FontWeight.bold),))

                ],

              ),
          ),
      ),
    );
  }
}