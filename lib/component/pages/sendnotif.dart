import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/coursedetailadmn.dart';

class SendNotifPage extends StatelessWidget {
  SendNotifPage({super.key});
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
          backgroundColor: const Color(0xFF4A1C6F),
          title: const Text('Send Notification' , style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
           bottom: const TabBar(
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
            ),
            labelStyle:  TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            unselectedLabelStyle:  TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            tabs:  [
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

  const CourseList({required this.courses ,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Find by location, name',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: ListTile(
                    leading: Image.asset(course["image"]!, fit: BoxFit.cover, width: 60, height: 60),
                    title: Text(course["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course["location"]!),
                        Text(course["schedule"]!),
                        Text(course["description"]!),
                        const SizedBox(height: 4),
                        Text('by ${course["instructor"]!}', style:const TextStyle(fontWeight: FontWeight.bold)),
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
