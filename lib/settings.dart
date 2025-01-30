import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
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
              Navigator.pushNamed(context, '/homepage');
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            ),
          )),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green, Colors.black])),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("images/pfp.jpg"),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spidey Boy",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppy'),
                        ),
                        Text(
                          '@spidey69',
                          style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'poppylight',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //overlay

              const SizedBox(height: 20),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Text(
                      "Profile Settings",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppy',
                          color: Colors.grey),
                    ),
                    settingsTile(Icons.person, "Change Username"),
                    settingsTile(Icons.person, "Change Display Name"),
                    settingsTile(Icons.person, "Change Password"),
                    const SizedBox(height: 15),
                    Text(
                      'App Settings',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppy',
                          color: Colors.grey),
                    ),
                    settingsTile(Icons.palette, "Appearance"),
                    settingsTile(Icons.info, "About Brokecheck"),
                    settingsTile(Icons.delete, "Delete Account"),
                    const SizedBox(height: 20),
                    logoutButton(context)
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}

Widget settingsTile(IconData icon, String title) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'quickie',
      ),
    ),
    onTap: () {},
  );
}

Widget logoutButton(context) {
  return Center(
    child: TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/getstarted');
        },
        icon: Icon(
          Icons.logout,
          color: Colors.red,
          size: 30,
        ),
        label: Text("Logout",
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontFamily: 'quickie',
                fontWeight: FontWeight.bold))),
  );
}
