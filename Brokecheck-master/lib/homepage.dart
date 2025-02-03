// ignore_for_file: unused_import

import 'package:brokecheck/addcashbook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brokecheck/customnavbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser == null || currentUser!.email == null) {
      throw Exception("User not logged in or email is null");
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
        title: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                  color: Colors.red,
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

      // Floating Action Button for the entire Scaffold
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                showAddCashbookModal(context);
              },
              icon: const Icon(
                Icons.add,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                "Add Cashbook",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppylight',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              backgroundColor: Colors.greenAccent[100],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          // Your Favourites text
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
          // Container with withdraw and deposit
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
          const SizedBox(height: 20),
          // Cashbook section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cashbooks',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppy',
                    color: Colors.black54,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.filter_list),
                      iconSize: 30,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10),
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cashbook data')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cashbooks = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cashbooks.length,
                  itemBuilder: (context, index) {
                    final cashbookData =
                        cashbooks[index].data() as Map<String, dynamic>;
                    return CashbookListItem(cashbookData: cashbookData);
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CashbookListItem extends StatelessWidget {
  final Map<String, dynamic> cashbookData;

  const CashbookListItem({super.key, required this.cashbookData});

  @override
  Widget build(BuildContext context) {
    final iconData = IconData(
      cashbookData['icon'] ?? Icons.account_balance_wallet.codePoint,
      fontFamily: 'MaterialIcons',
    );
    final cashbookName = cashbookData['name'];
    final createdAt = cashbookData['created_at'];
    final formattedDate = createdAt != null
        ? DateFormat('MMM d, yyyy').format(createdAt.toDate())
        : 'N/A';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(iconData, color: Colors.black54, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cashbookName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'poppy',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: 'poppylight',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    // Handle edit or delete functionality
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.grey, // Color of the divider
          height: 1, // Height of the divider
          thickness: 1, // Thickness of the divider line
          indent: 16, // Indent from the left
          endIndent: 16, // Indent from the right
        ),
      ],
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Subscription Page'),
    );
  }
}

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Cards Page'),
    );
  }
}
