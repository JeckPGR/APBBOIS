import 'package:flutter/material.dart';
import 'englishpage.dart';
import 'programmingpage.dart';

void main() => runApp(const MaterialApp(home:  CoursePage()));

class CoursePage extends StatelessWidget {
   const CoursePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title:const  Text('Courses' , style: TextStyle(color: Colors.white),),
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
                backgroundColor:const Color.fromARGB(76, 245, 91, 212),
                imageAlignment: Alignment.bottomRight,
                navigateTo: const EnglishCoursesPage(),
                textColor: const Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 10),
              _buildImageCard(
                context: context,
                imagePath: 'assets/image/programming.png',
                label: 'Pemrograman',
                backgroundColor:const Color.fromARGB(160, 219, 97, 241),
                imageAlignment: Alignment.bottomLeft,
                navigateTo: const ProgrammingCoursesPage(),
                textColor:const Color(0xFF4A1C6F), // Same color as "Yang Mungkin Anda Sukai"
              ),
              const SizedBox(height: 20),
              const Text(
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
              const Text(
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
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        height: 120,
        child: Stack(
          children: [
            Align(
              alignment: imageAlignment,
              child:  SizedBox(
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
          )
        ),
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
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style:const TextStyle(color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children:  [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


