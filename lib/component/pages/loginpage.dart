import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signuppage.dart';
import 'homepage.dart';
import 'forgotpassword.dart';
import 'adminpage.dart';
import '../../Controller/firebase_auth_services.dart';

class LoginRegisterScreen extends StatefulWidget {
    const LoginRegisterScreen({super.key});
  @override
  State<LoginRegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginRegisterScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Color.fromARGB(218, 255, 255, 255))),
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1), // Add space before the content
                    Image.asset(
                      'assets/image/Login.png',
                      height: constraints.maxHeight * 0.2, // 20% of screen height
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      style:  const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email, color: Colors.white.withOpacity(0.4)),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                        labelStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w700),
                        border: const OutlineInputBorder(),
                        fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock, color: Colors.white.withOpacity(0.4)),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                        labelStyle: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w700),
                        border: const OutlineInputBorder(),
                        fillColor: const Color(0x406F1EAB).withOpacity(0.4),
                        filled: true,
                      ),
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _signIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
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
                          // Implement sign in with Google functionality here
                        },
                        icon: Image.asset('assets/image/google.png', height: 24), // Update this to your Google icon path
                        label: const Text('Sign in with Google', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side:  const BorderSide(color: Colors.white),
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(flex: 1), // Add space after the content
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _signIn() async {
  try {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      if (!mounted) return; // Check if the widget is still mounted
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('Users').doc(user.uid).get();

      if (!mounted) return; // Check again if the widget is still mounted
      Navigator.of(context).pop();

      if (userDoc.exists) {
        String role = userDoc.data()?['role'] ?? 'regular';

        if (role == "admin") {
          if (!mounted) return; // Check again if the widget is still mounted
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminPage()));
        } else {
          if (!mounted) return; // Check again if the widget is still mounted
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Homepage()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found in the database.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing in'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

}