import 'package:flutter/material.dart';

import 'CallHistoryScreen.dart';

import '../config/Pallete.dart' as Pallete;

class HomeScreen extends StatefulWidget {
  static const routeName = './home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    CallHistoryScreen(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Reorder',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/contact.png')),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/keypad.png')),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text(''),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Pallete.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
