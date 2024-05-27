import 'package:flutter/material.dart';

class DeleteRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner List'),
        backgroundColor: Color(0xFF4A1C6F),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          OwnerCard(
            name: "Ahmad Dzaky Ar Razi",
            company: "Harvard Cinderella",
            email: "dzakyrazi@gmail.com",
          ),
          OwnerCard(
            name: "Tasya Aulia Syahputri",
            company: "Mayapada English",
            email: "tyharapaph@gmail.com",
          ),
        ],
      ),
    );
  }
}

class OwnerCard extends StatelessWidget {
  final String name;
  final String company;
  final String email;

  OwnerCard({required this.name, required this.company, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.yellow),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(company),
                  Text(email),
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    // Implement delete functionality here
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Implement detail functionality here
                  },
                  child: Text('Detail'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DeleteRole(),
  ));
}
