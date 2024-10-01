import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  MyProfilePage({super.key});

  final Map<String, dynamic> userData = {
    "name": "Harsha Bellala",
    "date_of_birth": "2004-02-04",
    "home_city": "Visakhapatnam",
    "home_airport_code": "VTZ",
    "most_preferred_class": "Economy",
    "visited_cities": [
      {"city_code": "VTZ", "city_name": "Visakhapatnam", "visit_count": 10},
      {"city_code": "BLR", "city_name": "Bengaluru", "visit_count": 5},
      {"city_code": "DEL", "city_name": "Delhi", "visit_count": 3}
    ],
    "preferred_seats": [
      {"seat": "4F", "booking_count": 4},
      {"seat": "5F", "booking_count": 2},
      {"seat": "3E", "booking_count": 1}
    ],
    "preferred_departure_time": {"start": "10:00 AM", "end": "7:00 PM"},
    "food_preferences": [
      {"item": "Coffee + Sandwich", "selection_count": 3},
      {"item": "Tea + Snack Bag", "selection_count": 2}
    ],
    "flight_durations": {
      "morning": {"count": 4, "time_range": "5:00 AM - 11:59 AM"},
      "noon": {"count": 3, "time_range": "12:00 PM - 5:59 PM"},
      "evening": {"count": 5, "time_range": "6:00 PM - 9:59 PM"},
      "midnight": {"count": 2, "time_range": "10:00 PM - 4:59 AM"}
    },
    "joined_akasa": "2024-05",
    "email": "harsha@example.com",
    "phone": "+919876543210"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Light Grey background
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: constraints.maxWidth > 600 // Check if width is more than 600px (desktop/tablet view)
                ? _buildWideLayout() // Display a grid-like layout on wider screens
                : _buildNarrowLayout(), // Display column layout on mobile
          );
        },
      ),
    );
  }

  // Layout for wide screens (desktop)
  Widget _buildWideLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Personal Info'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildUserInfoCard()),
            const SizedBox(width: 16),
            Expanded(child: _buildPreferencesCard()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTravelHistoryCard()),
            const SizedBox(width: 16),
            Expanded(child: _buildCitiesAndFoodCard()),
          ],
        ),
      ],
    );
  }

  // Layout for narrow screens (mobile)
  Widget _buildNarrowLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Personal Info'),
        _buildUserInfoCard(),
        const SizedBox(height: 16),
        _buildPreferencesCard(),
        const SizedBox(height: 16),
        _buildTravelHistoryCard(),
        const SizedBox(height: 16),
        _buildCitiesAndFoodCard(),
      ],
    );
  }

  // User Info Card
  Widget _buildUserInfoCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoRow('Name', userData['name']),
            _buildUserInfoRow('Date of Birth', userData['date_of_birth']),
            _buildUserInfoRow('Home City', userData['home_city']),
            _buildUserInfoRow('Home Airport Code', userData['home_airport_code']),
          ],
        ),
      ),
    );
  }

  // Preferences Card
  Widget _buildPreferencesCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoRow('Most Preferred Class', userData['most_preferred_class']),
            _buildUserInfoRow(
              'Preferred Departure Time',
              '${userData['preferred_departure_time']['start']} - ${userData['preferred_departure_time']['end']}',
            ),
            const SizedBox(height: 16),
            _buildChipSectionWithCount('Preferred Seats', userData['preferred_seats'], 'seat', 'booking_count'),
          ],
        ),
      ),
    );
  }

  // Travel History Card
  Widget _buildTravelHistoryCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('Travel History'),
            _buildUserInfoRow('Joined Akasa', userData['joined_akasa']),
          ],
        ),
      ),
    );
  }

  // Cities and Food Card
  Widget _buildCitiesAndFoodCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChipSectionWithCount('Food Preferences', userData['food_preferences'], 'item', 'selection_count'),
            const SizedBox(height: 16),
            _buildChipSectionWithCount('Visited Cities', userData['visited_cities'], 'city_name', 'visit_count'),
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
        style: const TextStyle(
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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF666666), // Grey for subtext
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF000000), // Black/Dark Grey for primary text
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis, // Handle overflow gracefully
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSectionWithCount(String title, List<Map<String, dynamic>> items, String labelKey, String countKey) {
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
                '${item[labelKey]} (${item[countKey]})',
                style: const TextStyle(color: Color(0xFFFFFFFF)), // White text color
              ),
              backgroundColor: const Color(0xFFFF6600), // Orange for chips
            );
          }).toList(),
        ),
      ],
    );
  }
}
