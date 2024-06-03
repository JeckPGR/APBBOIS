import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/fragments/google_navbar.dart';
import 'package:flutter_application_1/component/pages/coursepage.dart';
import 'package:flutter_application_1/component/pages/profilepage.dart';
import 'package:flutter_application_1/component/pages/coursedetail.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  HomepageState createState() => HomepageState();
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



class HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Default to Home
  String _selectedCategory = 'Programming'; // Default selected category
  String? myusername;
  @override
  void initState(){
    super.initState();
  }

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

  Future<void> _fetch() async {
    // Initialize Firebase if not already done (consider adding a check)
    await Firebase.initializeApp();

    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      try {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseUser.uid)
            .get();
        if (docSnapshot.exists) {
          myusername = docSnapshot.data()!['username'];
          print(myusername);
        } else {
          print('Username not found in document');
        }
      } on FirebaseException catch (e) {
        print('Error fetching username: $e');
      }
    } else {
      print('No signed-in user found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, // Remove default elevation (shadow)
        toolbarHeight: 10.0, // Reduce toolbar height
        backgroundColor: const Color(0xFF4A1C6F),
      ),
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
      return const CoursePage();
    } else {
      return const ProfilePage();
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
          decoration: const BoxDecoration(
            color: Color(0xFF4A1C6F),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,0.0,8.2,0),
                  child: FutureBuilder(
                    future: _fetch(),
                    builder: (context,snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator()); // Show a loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Handle errors gracefully
                      } else {
                        // Access and display fetched username or other data here
                        return Text('Hello, $myusername' , style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),); // Example: Display username if fetched
                      }
                    },
                  ),
                ),
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  Text('Jl. Sukabirus No 15', style: TextStyle(color: Colors.white)),
                  Spacer(),
                  // Icon(Icons.account_circle, color: Colors.white),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Find Course..',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromARGB(40, 217, 217, 217),
                  filled: true,
                ),
                style: const TextStyle(color: Colors.white),
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
                color: const Color(0xFF4A1C6F),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(
                          'New Course!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'UI-UX Research',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 5),
                         ElevatedButton  (
                          onPressed: () {
                            // Implement View Now functionality here
                          },  
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const  Color.fromARGB(255, 245, 91, 212),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const  Text('View Now', style:TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/image/newcourse.png', height: 120, fit: BoxFit.contain),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Recommended Courses Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
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
                    const Text(
                      'Course',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        _onTabChange(1); // Change to the Course page tab
                      },
                      child: const Text('Show All'),
                    ),
                  ],
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      _buildCategoryButton('Programming'),
                      _buildCategoryButton('English'),
                      _buildCategoryButton('Coming Soon...'),
                    ],
                  ),
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 210,
        width: 160,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white, // Custom background color
          borderRadius: BorderRadius.circular(4.0), // Custom border radius
          border: Border.all(
            color: const Color.fromARGB(255, 207, 205, 205), // Custom border color
            width: 0.5, // Custom border width
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(course.imagePath, height: 100, fit: BoxFit.cover),
            const SizedBox(height: 5),
            Text(
              course.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              course.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Changed from clip to ellipsis
              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w200),
            ),
            const Row(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _selectedCategory == category ? const Color(0xFF4A1C6F) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xFF4A1C6F)),
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
      return  const Padding(
        padding: EdgeInsets.symmetric(vertical: 28.0),
        child:  Center(
          child: Text(
            'Coming Soon...',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45),
          ),
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(location, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(width: 10),
                      Text(distance, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(schedule, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      // Implement View Details functionality here
                    },
                    child: const Text('View Details', style: TextStyle(color: Color(0xFF4A1C6F))),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A1C6F),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
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
