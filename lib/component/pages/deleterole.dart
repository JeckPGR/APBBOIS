import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Model/Owner.dart';
import 'deletedetailadmin.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DeleteRole extends StatefulWidget {
  const DeleteRole({super.key});

  @override
  State<DeleteRole> createState() => _DeleteRoleState();
}

class _DeleteRoleState extends State<DeleteRole> {
  List<Owner> owners = [];

  void _fetchOwners() async {
    final ownerDocs = await FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'Owner Course')
        .get();

    final ownerData = ownerDocs.docs.map((doc) => {
          ...doc.data(),
          'docId': doc.id, // Add docId to the data map
        }).toList();

    final owners = ownerData.map((owner) async {
      final coursesRef = await FirebaseFirestore.instance
          .collection('Courses')
          .where('ownerId', isEqualTo: owner['uid'])
          .get();

      final coursesData = coursesRef.docs.map((doc) => doc.data()).toList();

      return Owner(
        name: owner['username']?.toString() ?? '',
        email: owner['email'] as String,
        courses: coursesData,
        docId: owner['docId'] as String, // Use docId from the map
      );
    }).toList();

    final resolvedOwners = await Future.wait(owners.map((e) => e).toList()); // Wait for all futures
    setState(() {
      this.owners = resolvedOwners.cast<Owner>();
    });
  }

 void _downPrivilage(String docId) async {
  try {
    // Update the user's role to 'Student' and delete their courses field
    await FirebaseFirestore.instance.collection('Users').doc(docId).update({
      'role': 'Student', // Set role to 'Student'
      'courses': FieldValue.delete(), // Delete ownership of courses
      'requestbecomeowner': FieldValue.delete(), // Delete requestbecomeowner
      'isDownPrivilage': true, // Mark
    });

    // Fetch the courses owned by the user
    final courseQuery = FirebaseFirestore.instance
        .collection('Courses')
        .where('ownerId', isEqualTo: docId);

    final querySnapshot = await courseQuery.get();

    for (var courseDoc in querySnapshot.docs) {
      final courseId = courseDoc.id;
      final courseData = courseDoc.data();
      final courseImageUrl = courseData['course_image_url'] as String?;

      // Delete each course document
      await courseDoc.reference.delete();

      // Fetch and delete associated registrants in the 'Registrants' collection
      final registrantQuery = FirebaseFirestore.instance
          .collection('Registrants')
          .where('course_id', isEqualTo: courseId);

      final registrantSnapshot = await registrantQuery.get();

      for (var registrantDoc in registrantSnapshot.docs) {
        await registrantDoc.reference.delete();
      }

      final syllabusQuery = FirebaseFirestore.instance
          .collection('Syllabus')
          .where('courseId', isEqualTo: courseId);

      final syllabusSnapshot = await syllabusQuery.get();

      for (var syllabusDoc in syllabusSnapshot.docs) {
        await syllabusDoc.reference.delete();
      }

      // Delete course image from Firebase Storage if it exists
      if (courseImageUrl != null && courseImageUrl.isNotEmpty) {
        try {
          final Reference imageRef = FirebaseStorage.instance.refFromURL(courseImageUrl);
          await imageRef.delete();
        } catch (e) {
          print('Error deleting course image: $e');
        }
      }
    }
    // Refresh the list after deletion
    _fetchOwners();
  } catch (e) {
    print('Error deleting owner: $e');
  }
}



  @override
  void initState() {
    super.initState();
    _fetchOwners(); // Fetch data on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Owner List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: owners.isEmpty
          ? Center(
              child: Text(
                'Tidak ada owner yang terdaftar',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: owners.length,
              itemBuilder: (context, index) {
                final owner = owners[index]; // Get the current owner object
                return OwnerCard(
                  name: owner.name,
                  company: owner.courses.map((course) => course['course_name'] as String).toList(),
                  email: owner.email,
                  onDelete: () => _downPrivilage(owner.docId), // Pass delete function
                  onDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerDetailsPage(owner: owner),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class OwnerCard extends StatelessWidget {
  final String name;
  final List<String> company;
  final String email;
  final VoidCallback onDelete;
  final VoidCallback onDetails;

  const OwnerCard({
    required this.name,
    required this.company,
    required this.email,
    required this.onDelete,
    required this.onDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade700,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        company.join(', '),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onDelete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: onDetails,
                  child: const Text('Detail'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
