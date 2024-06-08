import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'englishpage.dart';
import 'programmingpage.dart';
import 'coursedetail.dart';
import '../../Model/Course.dart';
import 'package:get/get.dart'; 

void main() => runApp(const MaterialApp(home: CoursePage()));

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Course> likedCourses = [];
  List<Course> nearbyCourses = [];

  @override
  void initState() {
    super.initState();
    fetchLikedCourses();
    fetchNearbyCourses();
  }

  Future<void> fetchLikedCourses() async {
    try {
      final coursesQuerySnapshot = await FirebaseFirestore.instance.collection('Courses').get();

      List<Course> validCourses = [];

      for (var courseDoc in coursesQuerySnapshot.docs) {
        final ownerId = courseDoc['ownerId'];
        final ownerDoc = await FirebaseFirestore.instance.collection('Users').doc(ownerId).get();

        if (ownerDoc.exists && ownerDoc['role'] == 'Owner Course') {
          final course = Course.fromMap(courseDoc.data());
          if (course.courseRating > 2.4) {
            validCourses.add(course);
          }
        }
      }

      // Sort the valid courses based on rating
      validCourses.sort((a, b) => b.courseRating.compareTo(a.courseRating));

      // Take the top 4 courses based on rating
      setState(() {
        likedCourses = validCourses.take(4).toList();
      });

      for (var course in likedCourses) {
        print('Course: ${course.courseName}, Type: ${course.courseType}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  Future<void> fetchNearbyCourses() async {
    try {
      final coursesQuerySnapshot = await FirebaseFirestore.instance.collection('Courses').get();

      List<Course> validCourses = [];

      for (var courseDoc in coursesQuerySnapshot.docs) {
        final ownerId = courseDoc['ownerId'];
        final ownerDoc = await FirebaseFirestore.instance.collection('Users').doc(ownerId).get();

        if (ownerDoc.exists && ownerDoc['role'] == 'Owner Course') {
          validCourses.add(Course.fromMap(courseDoc.data()));
        }
      }

      setState(() {
        nearbyCourses = validCourses;
      });
    } catch (e) {
      print('Error fetching nearby courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Courses',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCard(
                context: context,
                imagePath: 'assets/image/english.png',
                label: 'Bahasa Inggris',
                gradientColors: [Colors.pink.shade100, Colors.pink.shade300],
                imageAlignment: Alignment.bottomRight,
                navigateTo: const EnglishCoursesPage(),
                textColor: const Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 10),
              _buildImageCard(
                context: context,
                imagePath: 'assets/image/programming.png',
                label: 'Pemrograman',
                gradientColors: [Colors.purple.shade100, Colors.purple.shade300],
                imageAlignment: Alignment.bottomLeft,
                navigateTo: const ProgrammingCoursesPage(),
                textColor: const Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 20),
              const Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A1C6F)),
              ),
              const SizedBox(height: 10),
              if (likedCourses.isEmpty)
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text('No courses available', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: likedCourses.map((course) => _buildCourseCard(course)).toList(),
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Courses in Your Area',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A1C6F)),
              ),
              const SizedBox(height: 10),
              if (nearbyCourses.isEmpty)
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text('No courses available', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: nearbyCourses.map((course) => _buildCourseCard(course)).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard({
    required BuildContext context,
    required String imagePath,
    required String label,
    required List<Color> gradientColors,
    required Alignment imageAlignment,
    required Widget navigateTo,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          navigateTo,
          transition: Transition.cupertinoDialog, // Use modern transition
          duration: const Duration(milliseconds: 800),
          
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: 120,
        child: Stack(
          children: [
            Align(
              alignment: imageAlignment,
              child: SizedBox(
                width: 195,
                height: 120,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: imageAlignment,
                  child: Image.asset(imagePath),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: imageAlignment == Alignment.bottomLeft
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: course),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 205,
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
              _buildImage(course.courseImageUrl),
              const SizedBox(height: 5),
              Text(
                course.courseName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                course.courseDescription,
                style: const TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(course.courseRating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: url.isEmpty || Uri.tryParse(url)?.hasAbsolutePath != true
          ? Image.asset(
              'assets/image/adminprofile.png',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.network(
              url,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/image/adminprofile.png',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
