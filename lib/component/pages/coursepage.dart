import 'package:flutter/material.dart';
import 'englishpage.dart';
import 'programmingpage.dart';

void main() => runApp(MaterialApp(home: CoursePage()));

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Color(0xFF4A1C6F),
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
                backgroundColor: Color.fromARGB(76, 245, 91, 212),
                imageAlignment: Alignment.bottomRight,
                navigateTo: EnglishCoursesPage(),
                textColor: Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 10),
              _buildImageCard(
                context: context,
                imagePath: 'assets/image/programming.png',
                label: 'Pemrograman',
                backgroundColor: Color.fromARGB(160, 219, 97, 241),
                imageAlignment: Alignment.bottomLeft,
                navigateTo: ProgrammingCoursesPage(),
                textColor: Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 20),
              Text(
                'Yang Mungkin Anda Sukai',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A1C6F)),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Terdekat Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A1C6F)),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                    _buildCourseCard(
                      title: 'Cinderella Kursus',
                      description: 'Tempat kursus bahasa Inggris yang inspiratif dan menarik.',
                      rating: '4.8',
                      imagePath: 'assets/image/Login.png',
                    ),
                  ],
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
    required Color backgroundColor,
    required Alignment imageAlignment,
    required Widget navigateTo,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        height: 120,
        child: Stack(
          children: [
            Align(
              alignment: imageAlignment,
              child: Container(
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

  Widget _buildCourseCard({
    required String title,
    required String description,
    required String rating,
    required String imagePath,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 160,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


