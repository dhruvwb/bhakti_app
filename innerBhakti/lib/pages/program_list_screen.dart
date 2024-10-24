import 'package:flutter/material.dart';
import 'package:inner_bhakti/pages/program_details_screen.dart';

class ProgramListScreen extends StatefulWidget {
  @override
  _ProgramListScreenState createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  int _selectedIndex = 0; // Track the selected index for bottom navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic based on selected index if needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top bar container
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade100, Colors.orange.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: Colors.black), // Left icon
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Text(
                      'InnerBhakti',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.refresh, color: Colors.black),
                          onPressed: () {
                            // Refresh logic here
                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            // Add logic here
                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Body content
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16.0),
              child: Text(
                'Prarthana Plans',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap:
                    true, // Allow the GridView to take up only the space it needs
                physics:
                    NeverScrollableScrollPhysics(), // Disable GridView scrolling
                crossAxisCount: 2, // Two cards in one row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(10, (index) {
                  return buildCard(
                    imageUrl:
                        'assets/images/image.jpeg', // Use your image asset
                    title: 'Work Stress ${index + 1}', // Dynamic title
                    plan: '20 Days Plan',
                    showLockIcon: true, // Show the lock icon
                    onTap: () {
                      // Handle the tap event
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgramDetailsScreen()),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
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
              child: Icon(Icons.dashboard, color: Colors.white), // Explore icon
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
    ));
  }

  Widget buildCard({
    required String imageUrl,
    required String title,
    required String plan,
    bool showLockIcon = false, // Parameter to control lock icon visibility
    required VoidCallback onTap, // Callback for when the card is tapped
  }) {
    return GestureDetector(
      onTap: onTap, // Call the provided function when the card is tapped
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Round the corners
        child: Container(
          decoration: BoxDecoration(
            color:
                Colors.black, // Set a default color or choose another approach
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  imageUrl, // Use the asset path
                  fit: BoxFit.cover, // Adjust the image to fit the card
                ),
              ),
              // Blackish overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0), // Transparent at the top
                        Colors.black.withOpacity(0.8), // Opaque at the bottom
                      ],
                    ),
                  ),
                ),
              ),
              // Lock icon (conditionally displayed)
              if (showLockIcon) // Only display if showLockIcon is true
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(4), // Padding around the icon
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(150, 229, 224, 221).withOpacity(
                          0.5), // Hazy transparent circular background color with reduced opacity
                      // Add blur effect
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              // Texts: Title and Plan
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      plan,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
