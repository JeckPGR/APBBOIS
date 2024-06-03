import 'package:flutter/material.dart';

class DeleteRole extends StatelessWidget {
   const DeleteRole({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner List' ,style: TextStyle(color:Colors.white),),
        backgroundColor:const Color(0xFF4A1C6F),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
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

  const OwnerCard({required this.name, required this.company, required this.email,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.yellow),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Implement detail functionality here
                  },
                  child:const  Text('Detail'),
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
  runApp(const MaterialApp(
    home: DeleteRole(),
  ));
}
