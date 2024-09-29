import 'package:flutter/material.dart';

class userinfoscreen extends StatelessWidget {
  final Map<String, dynamic> userData = {
    "name": "Harsha Bellala",
    "date_of_birth": "2004-02-04",
    "home_city": "Visakhapatnam",
    "home_airport_code": "VTZ",
    "most_preferred_class": "Economy",
    "visited_cities": [
      {"city_code": "VTZ", "city_name": "Visakhapatnam"},
      {"city_code": "BLR", "city_name": "Bengaluru"},
      {"city_code": "DEL", "city_name": "Delhi"}
    ],
    "preferred_seats": ["4F", "5F", "3E"],
    "preferred_departure_time": {"start": "10:00 AM", "end": "7:00 PM"},
    "food_preferences": ["Coffee + Sandwich", "Tea + Snack Bag"],
    "joined_akasa": "2024-05"
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Light Grey background
      appBar: AppBar(
        title: const Text('User Information', style: TextStyle(fontSize: 20)),
        backgroundColor: const Color(0xFFFF6600), // Orange primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeader('Personal Info'),
            _buildUserInfoRow('Name', userData['name']),
            _buildUserInfoRow('Date of Birth', userData['date_of_birth']),
            _buildUserInfoRow('Home City', userData['home_city']),
            _buildUserInfoRow('Home Airport Code', userData['home_airport_code']),
            const SizedBox(height: 16),

            _buildHeader('Preferences'),
            _buildUserInfoRow('Most Preferred Class', userData['most_preferred_class']),
            _buildUserInfoRow('Preferred Departure Time', '${userData['preferred_departure_time']['start']} - ${userData['preferred_departure_time']['end']}'),
            SizedBox(height: 16),

            _buildChipSection('Preferred Seats', userData['preferred_seats']),
            _buildChipSection('Food Preferences', userData['food_preferences']),
            _buildChipSection('Visited Cities', _getVisitedCities(userData['visited_cities'])),
            SizedBox(height: 16),

            _buildHeader('Travel History'),
            _buildUserInfoRow('Joined Akasa', userData['joined_akasa']),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF000000), // Black/Dark Grey for headers
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF666666), // Grey for subtext
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF000000), // Black/Dark Grey for primary text
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF000000), // Black/Dark Grey for headers
            ),
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items.map((item) {
            return Chip(
              label: Text(
                item,
                style: const TextStyle(color: Color(0xFFFFFFFF)), // White text color
              ),
              backgroundColor: const Color(0xFFFF6600), // Orange for chips
            );
          }).toList(),
        ),
      ],
    );
  }

  List<String> _getVisitedCities(List<Map<String, dynamic>> visitedCities) {
    return visitedCities.map((city) => city['city_name'].toString()).toList();
  }
}

void main() {
  runApp(MaterialApp(
    home: userinfoscreen(),
    theme: ThemeData(
      primaryColor: const Color(0xFFFF6600), // Orange primary color
      hintColor: const Color(0xFF6F2596), // Purple accent color for icons
      fontFamily: 'Roboto', // Using Roboto as the default font
    ),
  ));
}
