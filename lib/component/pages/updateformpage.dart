import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/component/pages/updatecourse.dart';
import '../../Model/Syllabus.dart';

class CourseUpdateFormPage extends StatelessWidget {
  final String courseId;

  CourseUpdateFormPage({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Course', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Courses').doc(courseId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Course not found'));
          }

          final courseData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CourseUpdateForm(courseData: courseData),
          );
        },
      ),
    );
  }
}

class CourseUpdateForm extends StatefulWidget {
  final Map<String, dynamic> courseData;

  CourseUpdateForm({required this.courseData});

  @override
  _CourseUpdateFormState createState() => _CourseUpdateFormState();
}

class _CourseUpdateFormState extends State<CourseUpdateForm> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _descriptionController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late TextEditingController _pricingController;
  late TextEditingController _subdistrictController;
  List<Syllabus> _syllabi = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.courseData['course_name']);
    _typeController = TextEditingController(text: widget.courseData['course_Type']);
    _descriptionController = TextEditingController(text: widget.courseData['course_description']);
    _emailController = TextEditingController(text: widget.courseData['course_email']);
    _phoneNumberController = TextEditingController(text: widget.courseData['course_phone_number']);
    _latitudeController = TextEditingController(text: widget.courseData['course_latitude'].toString());
    _longitudeController = TextEditingController(text: widget.courseData['course_longitude'].toString());
    _pricingController = TextEditingController(text: widget.courseData['course_pricing']);
    _subdistrictController = TextEditingController(text: widget.courseData['course_subdistrict']);
    _fetchSyllabi();
  }

  Future<void> _fetchSyllabi() async {
    final syllabusQuerySnapshot = await FirebaseFirestore.instance
        .collection('Syllabus')
        .where('courseId', isEqualTo: widget.courseData['courseId'])
        .get();
    setState(() {
      _syllabi = syllabusQuerySnapshot.docs.map((doc) => Syllabus.fromMap(doc.data())).toList();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _pricingController.dispose();
    _subdistrictController.dispose();
    super.dispose();
  }

  Future<void> _updateCourse() async {
    final courseRef = FirebaseFirestore.instance.collection('Courses').doc(widget.courseData['courseId']);

    try {
      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);
      await courseRef.update({
        'course_name': _nameController.text,
        'course_Type': _typeController.text,
        'course_description': _descriptionController.text,
        'course_email': _emailController.text,
        'course_phone_number': _phoneNumberController.text,
        'course_latitude': double.parse(_latitudeController.text),
        'course_longitude': double.parse(_longitudeController.text),
        'course_pricing': _pricingController.text,
        'course_subdistrict': _subdistrictController.text,
        'last_updated': timestamp,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateCoursePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Course updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update course: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTextField(_nameController, 'Course Name'),
          _buildTextField(_typeController, 'Course Type'),
          _buildTextField(_subdistrictController, 'Course Subdistrict'),
          _buildTextField(_descriptionController, 'Course Description'),
          _buildTextField(_emailController, 'Course Email'),
          _buildTextField(_phoneNumberController, 'Course Phone Number'),
          _buildTextField(_latitudeController, 'Course Latitude'),
          _buildTextField(_longitudeController, 'Course Longitude'),
          _buildTextField(_pricingController, 'Course Pricing'),
          const SizedBox(height: 20),
          _buildSyllabusList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _updateCourse,
            style: ElevatedButton.styleFrom(
             backgroundColor: const Color(0xFF4A1C6F),
            ),
            child: const Text('Update Course', style: TextStyle(fontSize: 12.0,color: Colors.white),),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSyllabusList() {
    if (_syllabi.isEmpty) {
      return const Text('Loading syllabi...');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Syllabi:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _syllabi.length,
          itemBuilder: (context, index) {
            final syllabus = _syllabi[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Text(syllabus.syllabusTitles),
                subtitle: Text('Meetings: ${syllabus.syllabusMeetings}'),
              ),
            );
          },
        ),
      ],
    );
  }
}
