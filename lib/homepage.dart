import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Spidey boy",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'poppy',
              fontWeight: FontWeight.bold,
              color: Colors.green),
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
      ),
      body: Column(
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
                color: Colors.green[100],
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
                            backgroundColor: Colors.black,
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
                            backgroundColor: Colors.black,
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
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // This will space out the items
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Filters',
                        style: TextStyle(
                            fontFamily: 'poppy',
                            color: const Color.fromARGB(255, 15, 94, 18)),
                      ),
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
                      trailing: Text(
                        "+6969",
                        style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppy'),
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
      ),
    );
  }
}
