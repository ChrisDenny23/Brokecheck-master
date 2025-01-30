// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import
import 'package:brokecheck/main.dart';
// ignore: depend_on_referenced_packages

class LoginSignupModal extends StatefulWidget {
  @override
  _LoginSignupModalState createState() => _LoginSignupModalState();
}

class _LoginSignupModalState extends State<LoginSignupModal> {
  bool isLogin = true; // Tracks whether the user is on Login or Signup

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildToggle(),
            const SizedBox(height: 20),
            isLogin ? buildLoginForm() : buildSignupForm(),
          ],
        ),
      ),
    );
  }

  Widget buildToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      // ignore: sort_child_properties_last
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLogin ? Colors.black : Colors.grey,
                        fontFamily: 'poppy'),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLogin ? Colors.grey : Colors.black,
                        fontFamily: 'poppy'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      width: 250,
      height: 50,
    );
  }

  Widget buildLoginForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Email or Username",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: true,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontFamily: 'poppy',
              fontSize: 10,
              color: const Color.fromARGB(255, 1, 38, 69),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(500, 50),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppy',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '──────────── OR ────────────',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'poppy',
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            // Handle Facebook login
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(Icons.facebook, size: 35),
          label: Text(
            "Login with Facebook",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppylight',
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            // Handle Google login
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(FontAwesomeIcons.google, size: 25),
          label: const Text(
            "Login with Google",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppylight',
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget buildSignupForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Username",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(500, 50),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Create Account",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppy',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '──────────── OR ────────────',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'poppy',
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            // Handle Facebook signup
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(Icons.facebook, size: 35),
          label: Text(
            "Sign up with Facebook",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppylight',
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            // Handle Google signup
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(FontAwesomeIcons.google, size: 25),
          label: const Text(
            "Sign up with Google",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppylight',
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
