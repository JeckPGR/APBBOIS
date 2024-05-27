import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/sendnotif.dart';

class CourseAdminDetailPage extends StatefulWidget {
  final Map<String, String> course;

  const CourseAdminDetailPage({required this.course});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseAdminDetailPage> {
  bool showNotificationForm = false;
  final TextEditingController notificationTitleController = TextEditingController();
  final TextEditingController notificationMessageController = TextEditingController();

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF4A1C6F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Notification Sent",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "You have notified the owner",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendNotifPage(),
                        ),
                      );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
        backgroundColor: Color(0xFF4A1C6F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DetailItem(title: "Owner", value: widget.course["instructor"]!),
            DetailItem(title: "Course name", value: widget.course["title"]!),
            DetailItem(title: "Course location", value: widget.course["location"]!),
            DetailItem(title: "Course subdistrict", value: "Dayeuhkolot"), // Update this as necessary
            DetailItem(title: "Course Description", value: widget.course["description"]!),
            SizedBox(height: 16.0),
            Text("Course Image", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Image.asset(widget.course["image"]!, fit: BoxFit.cover),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A1C6F), // background color
              ),
              onPressed: () {
                setState(() {
                  showNotificationForm = true;
                });
              },
              child: Text('Confirm Course'),
            ),
            if (showNotificationForm) ...[
              SizedBox(height: 16.0),
              Text("Insert Your Notification Info", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              TextField(
                controller: notificationTitleController,
                decoration: InputDecoration(
                  labelText: 'Notification Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: notificationMessageController,
                decoration: InputDecoration(
                  labelText: 'Notification Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A1C6F), // background color
                ),
                onPressed: () {
                  // Show notification dialog
                  _showNotificationDialog();
                },
                child: Text('Send Notification'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 4.0),
          Text(value),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
