import 'package:flutter/material.dart';
import 'package:inner_bhakti/pages/audio_player_screen.dart';

class ProgramDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image with Text Overlay
              Stack(
                children: [
                  Container(
                    height: screenSize.height * 0.3, // Responsive height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/course_header.jpeg'), // Replace with your asset image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Overlay for Title and Description
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Medito course',
                          style: TextStyle(
                            fontSize:
                                screenSize.width * 0.07, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4), // Reduced spacing
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(14.0), // Add padding around the text
                color: Color(0xFF292A33), // Set background color
                child: Text(
                  'The Medito course will help you to learn more about yourself, and the world around you. '
                  'Join us on this transformative journey of mindfulness, compassion, and insight.',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04, // Responsive font size
                    fontWeight: FontWeight.w600, // Make text bold
                    color: Colors.white70,
                  ),
                ),
              ),
              // List of Sections
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildSectionItem(
                      'Getting started', 'A few short intro sessions'),
                  _buildSectionItem(
                      'Learning to sit', 'Building up to 10 minutes'),
                  _buildSectionItem('Mindfulness', 'Build your practice'),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Left padding
                child: Text(
                  "Deepen Your Practices",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width * 0.045, // Responsive font size
                  ),
                ),
              ),
              // Back Button
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioPlayerScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example section item builder
  Widget _buildSectionItem(String title, String description) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            description,
            style: TextStyle(color: Colors.white70),
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5), // Grey color with 0.5 opacity
          thickness: 0.5, // Thickness of the divider
        ),
      ],
    );
  }
}
