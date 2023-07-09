import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Latest Notifications")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("New Updates on Magento 2"),
            onTap: (){
              // navigator
            },
            subtitle: Text("Find out the lastest updates ont the development of magento 2........"),
            // trailing: Icon(Icons.add,)
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("Importance Of SEO For E-Commerce Websites:"),
            onTap: (){
              // navigator
            },
            subtitle: Text(" Strategies For Optimizing Your Online Store"),
            // trailing: Icon(Icons.add,)
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("Personalized products on ecommerce"),
            onTap: (){
              // navigator
            },
            subtitle: Text("Latest personalization services using magento development"),
            // trailing: Icon(Icons.add,)
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("Local SEO In 2023: "),
            onTap: (){
              // navigator
            },
            subtitle: Text("Best Practices To Improve Your Local Search Rankings And Connect With Nearby Customers"),
            // trailing: Icon(Icons.add,)
          ),
          ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text("Magento 2.4.6"),
            onTap: (){
              // navigator
            },
            subtitle: Text("Everything You Need To Know About Magento 2.4.6 Release"),
            // trailing: Icon(Icons.add,)
          ),
        ],
      ),
    );
  }
}