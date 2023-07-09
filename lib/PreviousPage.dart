import 'package:flutter/material.dart';

class PreviousPage extends StatelessWidget {
  final List<String> invoices = [
    'Invoice 1',
    'Invoice 2',
    'Invoice 3',
    // Add more invoices here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Used for removing back button.
        title: Center(
          child: Text('Previous Order'),
        ),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return ListTile(
            title: Text(invoice),
            onTap: () {
              // Handle invoice tap event here
            },
          );
        },
      ),
    );
  }
}
