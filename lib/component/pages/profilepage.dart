import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/loginpage.dart';
import 'package:flutter_application_1/component/pages/personalinfo.dart';
import 'package:flutter_application_1/component/pages/coursedetail.dart';
import 'package:flutter_application_1/component/pages/requestowner.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 20, 88),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/image/profile.png'), // Replace with the actual image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alyssia Bahrain',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Student',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Your Course',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCourseCard(
                      context,
                      title: 'Harvard Cinderella',
                      rating: '4.8',
                      weeks: 'On Weeks 7',
                      imagePath: 'assets/image/profile.png', // Replace with the actual image asset path
                      description: 'This is a detailed description of the Harvard Cinderella course.',
                      courseDays: ['MON', 'WED', 'FRI'],
                      holidays: ['SAT', 'SUN'],
                    ),
                    _buildCourseCard(
                      context,
                      title: 'IT Bandung Netbeans',
                      rating: '3.5',
                      weeks: 'On Weeks 2',
                      imagePath: 'assets/image/image2.png', // Replace with the actual image asset path
                      description: 'This is a detailed description of the IT Bandung Netbeans course.',
                      courseDays: ['TUE', 'THU'],
                      holidays: ['SAT', 'SUN'],
                    ),
                    _buildCourseCard(
                      context,
                      title: 'Another Course',
                      rating: '4.8',
                      weeks: 'On Weeks 5',
                      imagePath: 'assets/image/logo_edulocal.png', // Replace with the actual image asset path
                      description: 'This is a detailed description of another course.',
                      courseDays: ['WED', 'FRI'],
                      holidays: ['SAT', 'SUN'],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Find More',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildListTile(
                icon: Icons.person,
                title: 'Personal Information',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.support_agent,
                title: 'Customer Support',
                onTap: () {
                  // Handle customer support tap
                },
              ),
              _buildListTile(
                icon: Icons.badge,
                title: 'Badge Information',
                onTap: () {
                  // Handle badge information tap
                },
              ),
              _buildListTile(
                icon: Icons.people,
                title: 'Request Become Owner',
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RequestOwnerPage(),
                  ),
                );
                },
              ),
              _buildListTile(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String title,
    required String rating,
    required String weeks,
    required String imagePath,
    required String description,
    required List<String> courseDays,
    required List<String> holidays,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              title: title,
              description: description,
              imagePath: imagePath,
              courseDays: courseDays,
              holidays: holidays,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 160,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagePath, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                rating,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                weeks,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog and do nothing
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginRegisterScreen()),
                  (Route<dynamic> route) => false,
                ); // Navigate to login page
              },
            ),
          ],
        );
      },
    );
  }
}
