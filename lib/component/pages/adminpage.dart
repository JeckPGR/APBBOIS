import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/confirm.dart';
import 'package:flutter_application_1/component/pages/deleterole.dart';
import 'package:flutter_application_1/component/pages/sendnotif.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Background color of the body
      appBar: AppBar(
        backgroundColor: Color(0xFF4A1C6F), // AppBar background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF4A1C6F), // Purple color
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Admin Dashboard',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/image/adminprofile.png'), // Replace with your avatar image path
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Owner Management',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ManagementCard(
                          iconPath: 'assets/image/sendnotif.png', // Replace with your icon image path
                          label: 'Send Notification',
                          onTap: () {
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SendNotifPage()),
                            );
                          },
                        ),
                        ManagementCard(
                          iconPath: 'assets/image/deleterole.png', // Replace with your icon image path
                          label: 'Delete Role',
                          onTap: () {
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => DeleteRole()),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ManagementCard(
                        iconPath: 'assets/image/confirm.png', // Replace with your icon image path
                        label: 'Confirm Request',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Confirm()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 60),
                    Text(
                      'App Management',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(154, 105, 91, 117), // Button background color
                          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Add your onTap functionality here
                        },
                        child: Text(
                          'Send Notification App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ManagementCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const ManagementCard({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, height: 50), // Displaying icon image
              SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
