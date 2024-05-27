import 'package:flutter/material.dart';
import 'emailverification.dart';  // Import the email verification screen

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password', style: TextStyle(color: Color.fromARGB(218, 255, 255, 255))),
        backgroundColor: const Color(0xFF4A1C6F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4A1C6F),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // Add some space at the top
              const Text(
                'Your Email Address',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter your email address associated with your account',
                style: TextStyle(color: Color.fromARGB(122, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                  filled: true,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Make the button take the full width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
                    );
                  },
                  child: const Text('Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F1EAB), // Button color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
