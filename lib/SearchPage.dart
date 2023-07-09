import 'package:app/ItemPage.dart';
import 'package:app/ItemPage2.dart';
import 'package:app/ItemPage3.dart';
import 'package:app/ItemPage4.dart';
import 'package:app/ItemPage5.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  late String name, email;
  final bool isLoggedIn;
  SearchPage({Key? key, required this.title,required this.isLoggedIn, required this.email,}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();

  final List<String> duplicateItems = [ "Partial Payment",
    "Stripe Payment",
    "Subscription & Recurring",
    "Barcode Extension",
    "Personalized Products"];
  var items = <String>[];

  @override
  void initState() {
    items = duplicateItems;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Assuming the PriceList and ItemDetailsList
  List<int> PriceList = [72, 55, 264, 79, 102];
  List<String> ItemDetailsList = [
    "Partial Payment details",
    "Stripe Payment details",
    "Subscription & Recurring details",
    "Barcode Extension details",
    "Personalized Products details",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final itemName = items[index];
                  final itemPrice = PriceList[index]; // Assuming PriceList is accessible here
                  final itemDetails = ItemDetailsList[index]; // Assuming ItemDetailsList is accessible here

                  return ExpansionTile(
                    title: Text(itemName),
                    children: [
                      ListTile(
                        title: Text('Price: \$${itemPrice.toStringAsFixed(2)}'),
                      ),
                      ListTile(
                        title: Text('Details: $itemDetails'),
                      ),
                      ListTile(
                        title: Text('Tap for more details'),
                        onTap: () {
                          if(items[index] == "Partial Payment"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemPage(email: widget.email.toString(),isLoggedIn: widget.isLoggedIn)),
                            );
                          }
                          else if (items[index] == "Stripe Payment"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemPage2()),
                            );
                          }
                          else if (items[index] == "Subscription & Recurring"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemPage3()),
                            );
                          }
                          else if (items[index] == "Barcode Extension"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemPage4()),
                            );
                          }
                          else if (items[index] == "Personalized Products"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemPage5()),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}