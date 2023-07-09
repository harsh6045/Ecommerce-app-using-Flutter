import 'package:app/PdfPreviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HomePage.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

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
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(" Enter your Address ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Enter Your Address'),
                  onChanged: (value) {},
                ),
              ),
              /*Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid,color: Colors.black,width: 2),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: TextField(),
              ),*/
/*
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(" Summary ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                ),
              ),
*/

          /*Card(
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
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Qty 1"),
                    ),
                  ],
                ),
              ),
            ),
          );*/
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(" Payment Method ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                ),
              ),

              CreditCardWidget(
                width: 300,
                height: 150,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Card Number'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Expiry Date'),
                      onChanged: (value) {
                        setState(() {
                          expiryDate = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Card Holder Name'),
                      onChanged: (value) {
                        setState(() {
                          cardHolderName = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'CVV'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          cvvCode = value;
                        });
                      },
                      focusNode: FocusNode(),
                      obscureText: true,
                      maxLength: 3,
                      onTap: () {
                        setState(() {
                          isCvvFocused = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          isCvvFocused = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: InkWell(
          child: Container(
            height: 50,
            child: const Center(
              child: Text(
                'Buy Product',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text("Click here to buy the product"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // Perform the payment processing logic here
                        // If the payment is successful, show a toast message
                        bool paymentSuccessful = true; // Replace with actual payment logic

                        if (paymentSuccessful) {
                          Fluttertoast.showToast(
                            msg: "Product bought successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(isLoggedIn: true, email: '', name: ''),
                            ),
                          );
                        }
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(''),
            ),
          );
        },
        child: const Icon(Icons.picture_as_pdf_sharp),
      ),
    );
  }
}
