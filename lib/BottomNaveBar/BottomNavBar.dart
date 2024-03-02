import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:todo/HomePage/home.dart';
import 'package:todo/Menu/Menu.dart';
import 'package:todo/Profile/user_profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List screens = [
    Menu(),
    Home(),
    User_Profile()
  ];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(8),
            child: GNav(
              gap: 4,
              curve: Curves.easeIn,
              backgroundColor: Colors.transparent, // Set to transparent
              rippleColor: Colors.cyan,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              tabBackgroundGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.greenAccent, Colors.cyanAccent]
              ),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if(index == 2){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Profile()));
                }
              },
              tabs: [
                GButton(
                    iconColor: Colors.black,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.alternateList,
                    text: 'Menu'),
                GButton(
                    iconColor: Colors.black,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.tasks,
                    text: 'Tasks'),
                GButton(
                    iconColor: Colors.black,
                    iconActiveColor: Colors.white,
                    icon: LineIcons.user,
                    text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[_selectedIndex],
    );
  }
}
