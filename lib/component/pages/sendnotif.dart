import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/coursedetailadmn.dart';

class SendNotifPage extends StatelessWidget {
  final List<Map<String, String>> programmerCourses = [
    {
      "title": "Programmer Course 1",
      "location": "Jl. Teknologi No. 10",
      "schedule": "Senin - Jumat",
      "description": "Kursus pemrograman yang mendalam dan komprehensif...",
      "instructor": "John Doe",
      "image": "assets/image/image2.png", // Replace with your image path
    },
    {
      "title": "Programmer Course 2",
      "location": "Jl. Teknologi No. 20",
      "schedule": "Senin - Jumat",
      "description": "Belajar pemrograman dari dasar hingga mahir...",
      "instructor": "Jane Smith",
      "image": "assets/image/image2.png", // Replace with your image path
    },
    // Add more programmer courses here...
  ];

  final List<Map<String, String>> englishCourses = [
    {
      "title": "Harvard Cinderella",
      "location": "Jl. Sukabirus No. 26",
      "schedule": "Senin - Jumat",
      "description": "Tempat kursus bahasa Inggris yang inspiratif dan inklusif, menghadirka...",
      "instructor": "Ahmad Dzaky Ar Razi",
      "image": "assets/image/newcourse.png", // Replace with your image path
    },
    {
      "title": "English Course 1",
      "location": "Jl. Sukabirus No. 26",
      "schedule": "Senin - Jumat",
      "description": "Tempat kursus bahasa Inggris yang inspiratif dan inklusif, menghadirka...",
      "instructor": "Kim Ji Won",
      "image": "assets/image/newcourse.png", // Replace with your image path
    },
    // Add more English courses here...
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4A1C6F),
          title: Text('Send Notification'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 255, 255, 255),
            tabs: [
              Tab(text: 'Programmer'),
              Tab(text: 'English'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CourseList(courses: programmerCourses),
            CourseList(courses: englishCourses),
          ],
        ),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final List<Map<String, String>> courses;

  const CourseList({required this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Find by location, name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(course["image"]!, fit: BoxFit.cover, width: 60, height: 60),
                    title: Text(course["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course["location"]!),
                        Text(course["schedule"]!),
                        Text(course["description"]!),
                        SizedBox(height: 4),
                        Text('by ${course["instructor"]!}', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseAdminDetailPage(course: course),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
