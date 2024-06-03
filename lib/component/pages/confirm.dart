import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
   const Confirm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Info' , style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          ApplicantCard(
            name: "Ahmad Dzaky Ar Razi",
            course: "IT Course Bandung",
            date: "08/11/2024",
            status: "Checking",
            statusColor: Colors.green,
          ),
          ApplicantCard(
            name: "Tasya Aulia Syahputri",
            course: "Mayapada English",
            date: "12/02/2024",
            status: "Pending",
            statusColor: Colors.red,
          ),
          ApplicantCard(
            name: "Nadia Zahira",
            course: "IT Course Bandung",
            date: "14/04/2023",
            status: "Cancelled",
            statusColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
  final String name;
  final String course;
  final String date;
  final String status;
  final Color statusColor;

  const ApplicantCard({
    required this.name,
    required this.course,
    required this.date,
    required this.status,
    required this.statusColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(course),
                  Text(date),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp( const MaterialApp(
    home: Confirm(),
  ));
}
