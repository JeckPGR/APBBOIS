import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/pages/formdaftar.dart';

class CourseDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<String> courseDays;
  final List<String> holidays;

  CourseDetailPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.courseDays,
    required this.holidays,
  });

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
        backgroundColor: Color(0xFF4A1C6F),
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
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Jalan Buah Batu No 118',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Course Schedule',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF1C1B33),
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
                  Text(
                    'Comments (5)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      CommentWidget(
                        name: 'Goo Youn Jung',
                        comment: 'Lorem ipsum dolor sit amet...',
                        type: 'Linguist',
                      ),
                      CommentWidget(
                        name: 'Baek Song min',
                        comment: 'Lorem ipsum dolor sit amet...',
                        type: 'Scholar',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Overall Rating',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '8.5',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => Icon(Icons.star, color: Colors.yellow),
                          ),
                        ),
                        Text(
                          'Based on 3 Reviews',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FormDaftar()),
                        );
                      },
                      child: Text('Daftar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A1C6F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
  final String type;

  CommentWidget({
    required this.name,
    required this.comment,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(comment),
              ],
            ),
          ),
          Chip(
            label: Text(type),
            backgroundColor: type == 'Scholar' ? Colors.purple : Colors.grey,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
