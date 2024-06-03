import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatelessWidget {
    SignUpScreen({super.key});
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: fullnameController,
                  style: const TextStyle(color: Colors.white),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your fullname';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                     child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
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
                    onPressed: () async {
                      // await signUpWithGoogle(context);
                    },
                    icon: Image.asset('assets/image/google.png', height: 24), // Update this to your Google icon path
                    label: const Text('Sign Up with Google', style: TextStyle(color: Colors.white),),
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
      ),
    );
  }

 Future<void> signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the current user's ID
      String uid = userCredential.user!.uid;

      // Get the reference to the "Users" collection in Firestore
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

      // Create a new document for the user with their information
      await usersCollection.doc(uid).set({
        'uid': uid,
        'email': emailController.text,
        'password': passwordController.text, // Remember to securely hash the password before storing it
        'username': fullnameController.text,
        'role': 'regular',
      });

      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Successfully signed up!')));
      Navigator.of(context).pop(); // Optionally navigate to another page
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.message ?? 'An error occurred';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred')));
    }
  }

  // Future<void> signUpWithGoogle(BuildContext context) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully signed up with Google!')));
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Homepage())); // Optionally navigate to the homepage
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up with Google: ${e.message}')));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('An error occurred')));
  //   }
  // }

}
