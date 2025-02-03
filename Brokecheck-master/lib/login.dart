// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, duplicate_ignore
import 'package:brokecheck/helper_functions.dart';
import 'package:brokecheck/homepage.dart';
import 'package:brokecheck/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: depend_on_referenced_packages

class LoginSignupModal extends StatefulWidget {
  const LoginSignupModal({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginSignupModalState createState() => _LoginSignupModalState();
}

class _LoginSignupModalState extends State<LoginSignupModal> {
  //text =controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpwController = TextEditingController();
  bool isLogin = true; // Tracks whether the user is on Login or Signup

  //login method
  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context); // Close loading dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) Navigator.pop(context);
      // ignore: use_build_context_synchronously
      displayMessageToUser(e.code, context);
    }
  }

  //register method
  void registerUser() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure passwords match
    if (passwordController.text != confirmpwController.text) {
      //pop loading circle
      Navigator.pop(context);

      //show error message
      displayMessageToUser("Password don't match", context);
    }
    //if passwords do match
    else {
      // try creating account
      try {
        //create the user
        // ignore: unused_local_variable
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        //create a user document and collect them in firestore
        Future<void> createUserDocument(UserCredential? UserCredential) async {
          if (UserCredential != null && UserCredential.user != null) {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(UserCredential.user!.email)
                .set({
              'email': UserCredential.user!.email,
              'username': usernameController.text
            });
          }
        }

        //create a user document and add to firestore
        createUserDocument(userCredential);

        //pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);

        //display the message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

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
        //Email or username textfield
        Mytextfield(
            label: 'Email', obscureText: false, controller: emailController),

        const SizedBox(height: 15),

        //password textfield
        Mytextfield(
            label: 'Password',
            obscureText: true,
            controller: passwordController),

        // forgot password
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),

        const SizedBox(height: 16),

        //button for login
        ElevatedButton(
          onPressed: () {
            login();
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

        // or with divider
        Text(
          '──────────── OR ────────────',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'poppy',
          ),
        ),

        const SizedBox(height: 10),

        // login with facebook button
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

        //login with google button
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
        //username textfield
        Mytextfield(
            label: 'Username',
            obscureText: false,
            controller: usernameController),

        const SizedBox(height: 5),

        //email textfield
        Mytextfield(
            label: 'Email', obscureText: false, controller: emailController),

        const SizedBox(height: 5),

        //password textfield
        Mytextfield(
            label: 'Password',
            obscureText: true,
            controller: passwordController),

        const SizedBox(height: 5),

        //Confirm password textfield
        Mytextfield(
            label: 'Confirm Password',
            obscureText: true,
            controller: confirmpwController),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            registerUser();
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
