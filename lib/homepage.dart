import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brokecheck/customnavbar.dart';
import 'package:flutter/material.dart';
import 'package:brokecheck/mywidgets/cards.dart';
import 'package:brokecheck/mywidgets/accordion.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDetails() async {
    if (currentUser == null || currentUser!.email == null) {
      // throw Exception("User not logged in or email is null"); //! Chris's code line
      return null;
    }
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    const HomeContent(),
    const SubscriptionPage(),
    const CardsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
              return Text(
                "Error: ${snapshot.error}",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'poppy',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text(
                "Guest",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'poppy',
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              );
            }

            // Extract user data
            Map<String, dynamic>? user = snapshot.data!.data();
            String username = user?['username'] ?? "Guest";

            return Text(
              username,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'poppy',
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.black54,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("images/pfp.jpg"),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      // Display the selected page
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 1,
          color: Colors.grey,
        ),

        const SizedBox(height: 10),
        // your favourite text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Favourites',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppy',
                color: Colors.black54,
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        //container with withdraw and deposit
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.greenAccent[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cashbook name",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'poppylight')),
                SizedBox(height: 4),
                Text("+1234",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 15, 94, 18),
                        fontFamily: 'poppylight')),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/withdraw');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 30, 30, 30),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("-  Withdraw",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'poppy')),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/deposit');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 30, 30, 30),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("+  Deposit",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'poppy')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //cashbook section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // This will space out the items
            children: [
              // Cashbooks Text
              Text(
                'Cashbooks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppy',
                  color: Colors.black54,
                ),
              ),
              // Row for the Buttons (Filters and Search)
              Row(
                children: [
                  // Filters Button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list),
                    iconSize: 30,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10), // Space between buttons
                  // Search Icon Button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    iconSize: 30,
                    color: Colors.black54,
                  ),
                ],
              ),
            ],
          ),
        ),
        // Cashbooks List
        Expanded(
          child: ListView.builder(
            itemCount: 7, // Dummy data count
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[300],
                    ),
                    title: Text(
                      "CB Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppy'),
                    ),
                    subtitle: Text(
                      "Updated on date month year",
                      style: TextStyle(fontFamily: 'poppylight'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "+6969",
                          style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppy'),
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                  // Divider between cashbook items
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: 13, // Number of Accordions
        separatorBuilder: (context, index) => SizedBox(height: 12), // Spacing
        itemBuilder: (context, index) => Accordion(),
      ),
    );
  }
}

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: ListView(
        // spacing: 14,
        children: [
          Mycard(Cardtitle: "Abhishek"),
          Mycard(Cardtitle: "Abhishek"),
        ],
      ),
    );
  }
}
