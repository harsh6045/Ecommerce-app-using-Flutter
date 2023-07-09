import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<int> favoriteDataList = [];
  List<String> favoriteDataListName = [
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
    "assets/images/deal5.png"
  ];

  @override
  void initState() {
    super.initState();
    getFavoriteDataList().then((dataList) {
      setState(() {
        favoriteDataList = dataList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
      ),
      body: favoriteDataList.isEmpty
          ? const Center(
              child: Text('No favorite item selected'),
            )
          : ListView.builder(
              clipBehavior: Clip.antiAlias,
              itemCount: favoriteDataList.length,
              itemBuilder: (context, index) {
                final currentItem = favoriteDataList[index];
                return Dismissible(
                  background: Container(color: Colors.redAccent),
                  key: Key(currentItem.toString()),
                  onDismissed: (direction){
                    setState(() {
                      favoriteDataList.removeAt(index);
                      updateFavoriteDataList();
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Item dismissed',style: TextStyle(fontSize: 25),)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.white,
                    elevation: 6,
                    shadowColor: Colors.blueGrey,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImagesList[currentItem - 1]),
                      ),
                      title: Text(
                        favoriteDataListName[currentItem - 1],
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          setState(() {
                            favoriteDataList.removeAt(index);
                            updateFavoriteDataList();
                          });
                        },
                        /*style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),*/
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ),
                      ),
                      // Add additional properties as needed for your item
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<List<int>> getFavoriteDataList() async {
    var sharedPref = await SharedPreferences.getInstance();
    var favoriteDataList = sharedPref.getStringList('favoriteDataList') ?? [];
    return favoriteDataList.map(int.parse).toList();
  }

  Future<void> updateFavoriteDataList() async {
    var sharedPref = await SharedPreferences.getInstance();
    var stringList = favoriteDataList.map((item) => item.toString()).toList();
    await sharedPref.setStringList('favoriteDataList', stringList);
  }
}
