import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Register', style: TextStyle(color: Color.fromARGB(218, 255, 255, 255))),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Fullname',
                  hintText: 'Enter your fullname',
                  prefixIcon: Icon(Icons.person, color: Colors.white.withOpacity(0.4)),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  border: const OutlineInputBorder(),
                  fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                  filled: true,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: Colors.white.withOpacity(0.4)),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  border: const OutlineInputBorder(),
                  fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                  filled: true,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white.withOpacity(0.4)),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  border: const OutlineInputBorder(),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                  filled: true,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement sign up functionality here
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Or',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implement sign up with Google functionality here
                  },
                  icon: Image.asset('assets/image/google.png', height: 24), // Update this to your Google icon path
                  label: const Text('Sign Up with Google', style: TextStyle(color: Colors.white),),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
