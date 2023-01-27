// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/claims.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/happy-calls.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/interventions.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/profile.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/login_screen.dart';
import 'package:three_stars_services/ui/users_screen.dart';

class BottomNavController extends StatefulWidget {
  BottomNavController({Key? key}) : super(key: key);

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    Claims(),
    Interventions(),
    HappyCalls(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.sort_rounded,
                color: AppColors.deep_orange,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Claims"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Intervention",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_phone),
            label: "Happy call",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
}

Widget buildHeader(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;
  return Material(
      color: AppColors.deep_orange,
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, CupertinoPageRoute(builder: (_) => Profile()));
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    "https://assets.afcdn.com/story/20180728/1294326_w1080h687cx567cy383cxt0cyt0cxb1080cyb687.jpg"),
              ),
              SizedBox(height: 12),
              Text(
                user.email!,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ]),
          )));
}

Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 2,
      children: [
        ListTile(
          leading: Icon(Icons.assignment, color: AppColors.deep_orange),
          title: Text('Claims'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.dashboard, color: AppColors.deep_orange),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (_) => BottomNavController()));
          },
        ),
        ListTile(
          leading:
              Icon(Icons.admin_panel_settings, color: AppColors.deep_orange),
          title: Text('Users'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, CupertinoPageRoute(builder: (_) => UsersScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: AppColors.deep_orange),
          title: Text('Settings'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, CupertinoPageRoute(builder: (_) => SettingsScreen()));
          },
        ),
        Divider(
          color: Colors.black54,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app, color: AppColors.deep_orange),
          title: Text('Sign out'),
          onTap: () async {
            Navigator.of(context).pop();
            await FirebaseAuth.instance.signOut();
            Navigator.push(
                context, CupertinoPageRoute(builder: (_) => LoginScreen()));
          },
        )
      ],
    ));
