import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/formdaftar.dart';

class CourseDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<String> courseDays;
  final List<String> holidays;

  const CourseDetailPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.courseDays,
    required this.holidays,
    super.key
  });

  @override
  CourseDetailPageState createState() => CourseDetailPageState();
}

class CourseDetailPageState extends State<CourseDetailPage> {
  bool isDescriptionSelected = true;
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course detail', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imagePath, fit: BoxFit.cover, width: double.infinity),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDescriptionSelected = true;
                          });
                        },
                        child: Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDescriptionSelected ? Colors.purple : Colors.grey,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDescriptionSelected = false;
                          });
                        },
                        child: Text(
                          'SYLLABUS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: !isDescriptionSelected ? Colors.purple : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'JALAN BUAH BATU NO 118',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLoved ? Icons.favorite : Icons.favorite_border,
                          color: isLoved ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isLoved = !isLoved;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.share, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (isDescriptionSelected) ...[
                    const Text(
                      'DESCRIPTION',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ] else ...[
                    const Text(
                      'SYLLABUS',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Syllabus belum siap.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Text(
                    'COURSE SCHEDULE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1B33),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ['SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI']
                          .map((day) => Text(
                                day,
                                style: TextStyle(
                                  color: widget.holidays.contains(day)
                                      ? Colors.red
                                      : widget.courseDays.contains(day)
                                          ? Colors.white
                                          : Colors.grey,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'COMMENTS (5)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      CommentWidget(
                        name: 'Goo Youn Jung',
                        comment: 'Lorem ipsum dolor sit amet...',
                      ),
                      CommentWidget(
                        name: 'Baek Song min',
                        comment: 'Lorem ipsum dolor sit amet...',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'OVERALL RATING',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
        
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          '8.5',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => const Icon(Icons.star, color: Colors.yellow),
                          ),
                        ),
                        const Text(
                          'Based on 3 Reviews',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const  FormDaftar()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A1C6F), // Warna latar belakang ungu
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          minimumSize: const Size(double.infinity, 50), // Tombol menjadi lebih lebar
                        ),
                          child: const Text(
                          'DAFTAR',
                          style: TextStyle(color: Colors.white), // Warna teks menjadi putih
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String name;
  final String comment;

  const CommentWidget({
    required this.name,
    required this.comment,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/image/programming.png'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  comment,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Text(
                  'Post sent | 1 days ago',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
