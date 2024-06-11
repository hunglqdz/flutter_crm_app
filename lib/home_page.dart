import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crm_app/pages/customer_management_page.dart';
import 'package:flutter_crm_app/pages/item_management_page.dart';
import 'package:flutter_crm_app/providers/item_provider.dart';
import 'package:provider/provider.dart';

import 'pages/customer_care_page.dart';
import 'pages/profile_page.dart';
import 'pages/reports_page.dart';

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
    'Reports',
  ];
  List<Widget> pages = [
    const ItemManagementPage(),
    const CustomerManagementPage(),
    const CustomerCarePage(),
    const ReportsPage(),
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex])),
      drawer: Consumer<ItemClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Drawer(
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
                selectedTileColor: Colors.blue,
                onTap: () {
                  onTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text(titles[1]),
                selected: selectedIndex == 1,
                selectedTileColor: Colors.blue,
                onTap: () {
                  onTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: Text(titles[2]),
                selected: selectedIndex == 2,
                selectedTileColor: Colors.blue,
                onTap: () {
                  onTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.auto_graph),
                title: Text(titles[3]),
                selected: selectedIndex == 3,
                selectedTileColor: Colors.blue,
                onTap: () {
                  onTapped(3);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
