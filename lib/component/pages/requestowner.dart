import 'package:flutter/material.dart';

class RequestOwnerPage extends StatefulWidget {
  const RequestOwnerPage({super.key});
  @override
  RequestOwnerPageState createState() => RequestOwnerPageState();
}

class RequestOwnerPageState extends State<RequestOwnerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseEmailController = TextEditingController();
  final TextEditingController _courseLocationController = TextEditingController();
  final TextEditingController _courseLatitudeController = TextEditingController();
  final TextEditingController _courseLongitudeController = TextEditingController();
  final TextEditingController _coursePhoneController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform the form submission logic, such as sending the data to the server
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(_getIconForLabel(labelText)),
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Name':
      case 'Course Name':
        return Icons.person;
      case 'Email':
      case 'Course Email':
        return Icons.email;
      case 'Phone Number':
      case 'Course Phone Number':
        return Icons.phone;
      case 'Course Location':
        return Icons.location_on;
      case 'Course Latitude':
      case 'Course Longitude':
        return Icons.public;
      default:
        return Icons.text_fields;
    }
  }

  // Widget _buildFileUploadField(String labelText) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(labelText),
  //       const SizedBox(height: 8),
  //       Container(
  //         height: 150,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey),
  //         ),
  //         child: Center(
  //           child: ElevatedButton(
  //             onPressed: () {
  //               // Handle file upload
  //             },
  //             child: const Text('Insert File'),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 58, 20, 88),
        title: const Text('Regist Owner' , style:TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Course Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text('Fill this form with your personal information'),
              const SizedBox(height: 16),
              _buildTextField(_nameController, 'Name'),
              _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              }),
              _buildTextField(_phoneController, 'Phone Number', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
               const Text(
                'Course Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text('Fill this form with your Course information'),
              const SizedBox(height: 16),
              _buildTextField(_courseNameController, 'Course Name'),
              _buildTextField(_courseEmailController, 'Course Email', keyboardType: TextInputType.emailAddress, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the course email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              }),
              _buildTextField(_courseLocationController, 'Course Location'),
              _buildTextField(_courseLatitudeController, 'Course Latitude', keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              _buildTextField(_courseLongitudeController, 'Course Longitude', keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              _buildTextField(_coursePhoneController, 'Course Phone Number', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
            
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
