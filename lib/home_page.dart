import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crm_app/pages/customer_management_page.dart';
import 'package:flutter_crm_app/pages/item_management_page.dart';

import 'pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  int selectedIndex = 0;
  List<String> titles = [
    'Item Management',
    'Customer Management',
    'Customer Care',
    'Statistic',
  ];
  List<Widget> pages = [
    const ItemManagementPage(),
    const CustomerManagementPage(),
    const Center(child: Text('Customer Care Page')),
    const Center(child: Text('Statistic Page')),
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(user.displayName!),
                subtitle: Text(user.email!),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(titles[0]),
              selected: selectedIndex == 0,
              selectedColor: Colors.blue,
              onTap: () {
                onTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: Text(titles[1]),
              selected: selectedIndex == 1,
              selectedColor: Colors.blue,
              onTap: () {
                onTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(titles[2]),
              selected: selectedIndex == 2,
              selectedColor: Colors.blue,
              onTap: () {
                onTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_graph),
              title: Text(titles[3]),
              selected: selectedIndex == 3,
              selectedColor: Colors.blue,
              onTap: () {
                onTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}