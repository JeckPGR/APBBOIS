import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/fragments/google_navbar.dart';
import 'package:flutter_application_1/component/pages/coursepage.dart';
import 'package:flutter_application_1/component/pages/profilepage.dart';
import 'package:flutter_application_1/component/pages/coursedetail.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class Course {
  final String title;
  final String description;
  final String imagePath;
  final List<String> courseDays;
  final List<String> holidays;

  Course({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.courseDays,
    required this.holidays,
  });
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Default to Home
  String _selectedCategory = 'Programming'; // Default selected category

  static List<Course> courses = [
    Course(
      title: 'Harvard Cinderella',
      description: 'Description. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/image/profile.png',
      courseDays: ['MON', 'TUE', 'WED', 'THU', 'FRI'],
      holidays: ['SAT', 'SUN'],
    ),
    Course(
      title: 'IT Bandung Netbeans',
      description: 'Another description here. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/image/image2.png',
      courseDays: ['MON', 'WED', 'FRI'],
      holidays: ['SAT', 'SUN', 'TUE', 'THU'],
    ),
    Course(
      title: 'Another Course',
      description: 'Yet another description here. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imagePath: 'assets/image/logo_edulocal.png',
      courseDays: ['MON', 'TUE', 'THU'],
      holidays: ['SAT', 'SUN', 'WED', 'FRI'],
    ),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildPageContent(),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedIndex == 0) {
      return _buildHomePage();
    } else if (_selectedIndex == 1) {
      return CoursePage();
    } else {
      return ProfilePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Search Bar Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF4A1C6F),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Hello, Dzaky',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    Text('Jl. Sukabirus No 15', style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Icon(Icons.account_circle, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Find Course..',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromARGB(40, 217, 217, 217),
                    filled: true,
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // New Course Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFF4A1C6F),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Course!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'UI-UX Research',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            // Implement View Now functionality here
                          },
                          child: Text('View Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 245, 91, 212),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/image/newcourse.png', height: 120, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Recommended Courses Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Course',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: courses.map((course) => _buildRecommendedCourseCard(course)).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Course Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Course',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        _onTabChange(1); // Change to the Course page tab
                      },
                      child: Text('Show All'),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildCategoryButton('Programming'),
                    _buildCategoryButton('English'),
                    _buildCategoryButton('Coming Soon...'),
                  ],
                ),
                const SizedBox(height: 20),
                // Display courses based on selected category
                if (_selectedCategory.isNotEmpty) _buildCategoryCourses(_selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCourseCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              title: course.title,
              description: course.description,
              imagePath: course.imagePath,
              courseDays: course.courseDays,
              holidays: course.holidays,
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
              Image.asset(course.imagePath, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 5),
              Text(
                course.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                course.description,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Text('4.8'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () => _onCategorySelected(category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _selectedCategory == category ? Color(0xFF4A1C6F) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFF4A1C6F)),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: _selectedCategory == category ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCourses(String category) {
    // Example courses for each category
    Map<String, List<Map<String, String>>> categoryCourses = {
      'Programming': [
        {'title': 'Harvard Cinderella', 'location': 'Jl. Sukabirus No. 26', 'schedule': 'Senin - Jumat', 'distance': '1.5 Km away'},
        {'title': 'IT Bandung Netbeans', 'location': 'Jl. Sukabirus No. 15', 'schedule': 'Selasa - Kamis', 'distance': '2 Km away'},
        {'title': 'Another Course', 'location': 'Jl. Sukabirus No. 10', 'schedule': 'Senin - Rabu', 'distance': '1 Km away'},
      ],
      'English': [
        {'title': 'aji love rara', 'location': 'Jl. Sukabirus No. 26', 'schedule': 'Senin - Jumat', 'distance': '1.5 Km away'},
        {'title': 'aji love rara', 'location': 'Jl. Sukabirus No. 15', 'schedule': 'Selasa - Kamis', 'distance': '2 Km away'},
        {'title': 'aji love rara', 'location': 'Jl. Sukabirus No. 10', 'schedule': 'Senin - Rabu', 'distance': '1 Km away'},
      ],
    };

    if (category == 'Coming Soon...') {
      return Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categoryCourses[category]!
            .map((course) => _buildDetailedCourseCard(course['title']!, course['location']!, course['schedule']!, course['distance']!))
            .toList(),
      );
    }
  }

  Widget _buildDetailedCourseCard(String title, String location, String schedule, String distance) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/image/Login.png', height: 100, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(location, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(width: 10),
                      Text(distance, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(schedule, style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      // Implement View Details functionality here
                    },
                    child: Text('View Details', style: TextStyle(color: Color(0xFF4A1C6F))),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A1C6F),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Recommended',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
