import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

//logout method
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/getstarted', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'poppy',
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("images/pfp.jpg"),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "Loading...",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'poppy',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return const Text(
                                "Error",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'poppy',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            }

                            if (snapshot.hasData && snapshot.data!.exists) {
                              return Text(
                                snapshot.data!['username'],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'poppy',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }
                            return const Text(
                              "Guest",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'poppy',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      sectionTitle("App Settings"),
                      const SizedBox(height: 10),
                      settingsTile(Icons.lock_outline, "Change Password"),
                      settingsTile(Icons.palette_outlined, "Appearance"),
                      settingsTile(Icons.info_outline, "About Brokecheck"),
                      settingsTile(Icons.delete_outline, "Delete Account"),
                      const SizedBox(height: 100),
                      logoutButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget settingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontFamily: 'quickie'),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: () {},
    );
  }

  Widget logoutButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout, color: Colors.red, size: 30),
        label: const Text(
          "Logout",
          style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontFamily: 'quickie',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'poppy',
          color: Colors.grey),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Logout",
          style: TextStyle(
              fontFamily: 'poppy', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(fontFamily: 'quickie'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style:
                  TextStyle(fontFamily: 'poppy', fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logout(context);
            },
            child: const Text("Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'poppy',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
