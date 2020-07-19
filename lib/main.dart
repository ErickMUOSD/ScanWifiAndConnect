import 'package:flutter/material.dart';
import 'instructions.dart';
import 'scanwifi.dart';
import 'contact.dart';

void main() => runApp(NavigationBar());

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedPage = 0;
  final _pageOptions = [
    Instructions(),
    MyHomePage(),
    Contact(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Color(0xff4A7375),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16,
          unselectedFontSize: 13,
          unselectedItemColor: Color(0xff7BA2A4),
          selectedItemColor: Color(0xff184042),
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Instructions'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Scan wifi'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              title: Text('Contact'),
            )
          ],
        ),
      ),
    );
  }
}
