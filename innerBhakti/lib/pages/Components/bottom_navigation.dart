import 'package:flutter/material.dart';
import '../program_list_screen.dart'; // Import the ProgramListScreen

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 1; // The initial selected index is 'Explore'

  // List of screens to navigate to
  final List<Widget> _screens = [
    Center(child: Text('Guide Page', style: TextStyle(fontSize: 24))),
    ProgramListScreen(), // The ProgramListScreen for the Explore tab
    Center(child: Text('Me Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), // Guide icon
              label: 'Guide',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(Icons.dashboard, color: Colors.white), // Explore icon
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), // Me icon
              label: 'Me',
            ),
          ],
          selectedItemColor: Colors.orange, // Color of the selected item
          unselectedItemColor: Colors.black, // Color of unselected items
          showUnselectedLabels: true, // Show labels for unselected items
        ),
      ),
    );
  }
}
