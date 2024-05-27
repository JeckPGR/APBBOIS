import 'package:flutter/material.dart';
import 'resetpassword.dart';

class EmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Email Verification', style: TextStyle(color: Color.fromARGB(218, 255, 255, 255))),
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
              const SizedBox(height: 50), // Adjust the space at the top
              const Text(
                'Get Your OTP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter the 4 digit code sent to your email address',
                style: TextStyle(color: Color.fromARGB(182, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _otpTextField(context),
                  _otpTextField(context),
                  _otpTextField(context),
                  _otpTextField(context),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                    );
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F1EAB), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(145, 110, 30, 171),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 24),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}
