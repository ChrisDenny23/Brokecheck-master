import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF2E7D32), Color(0XFF66BB6A)],
            ),
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
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF2E7D32), Color(0XFF66BB6A)],
              ),
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
                        const Text(
                          "Spidey Boy",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppy'),
                        ),
                        const Text(
                          '@spidey69',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      sectionTitle("Profile Settings"),
                      settingsTile(Icons.person, "Change Username"),
                      settingsTile(Icons.person, "Change Display Name"),
                      settingsTile(Icons.lock, "Change Password"),
                      const SizedBox(height: 10),
                      sectionTitle("App Settings"),
                      settingsTile(Icons.palette, "Appearance"),
                      settingsTile(Icons.info, "About Brokecheck"),
                      settingsTile(Icons.delete, "Delete Account"),
                      const SizedBox(height: 20),
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
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'poppy',
          color: Colors.grey),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
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
              Navigator.pushNamed(context, '/getstarted');
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
