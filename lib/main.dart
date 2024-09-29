import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scheme/splash%20screen.dart';
import 'chatbot.dart';  // Make sure to define this file properly
import 'userprofile.dart';  // Make sure to define this file properly

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6600), // Orange
        fontFamily: 'Roboto', // Use Roboto font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(), // Assuming Splash is already defined
        '/home': (context) => const HomeScreen(),
        '/anotherPage': (context) => const AnotherPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of widget pages to switch between
  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(), // Define this as the main home content
    BookingPage(), // Define this for booking
    ProfilePage(), // Define this for profile section
    MorePage(), // Define this for more options
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6600), // Orange
        title:  _selectedIndex == 2 // Only show title on Profile Page
            ? const Text('User Profile')
            : const Text('Akasa Air'),
      ),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex), // Display selected page
          // Chatbot icon with transition
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate with animation using PageRouteBuilder
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Slide from right to left
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ));
              },
              child: Image.asset(
                'assets/chatbot.png', // Your chatbot icon or lottie animation path
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6600), // Orange
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex, // Current selected index
        onTap: _onItemTapped, // Handle bottom navigation tap
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'Book',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

// Home Content Widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            color: const Color(0xFFFF6600), // Orange
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              children: [
                Text(
                  'Exclusive flight deals on AkasaAir.com and App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Login now and get up to 20% off. Use code: FLYMORE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), // Light Grey
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Text(
                  'Book a flight',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Plan your next trip with us',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Booking Page
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Booking Page Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Profile Page

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
      body: SingleChildScrollView( // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Personal Info'),
              _buildUserInfoRow('Name', userData['name']),
              _buildUserInfoRow('Date of Birth', userData['date_of_birth']),
              _buildUserInfoRow('Home City', userData['home_city']),
              _buildUserInfoRow('Home Airport Code', userData['home_airport_code']),
              const SizedBox(height: 16),
              _buildHeader('Preferences'),
              _buildUserInfoRow('Most Preferred Class', userData['most_preferred_class']),
              _buildUserInfoRow(
                  'Preferred Departure Time',
                  '${userData['preferred_departure_time']['start']} - ${userData['preferred_departure_time']['end']}'
              ),
              const SizedBox(height: 16),
              _buildChipSection('Preferred Seats', userData['preferred_seats']),
              _buildChipSection('Food Preferences', userData['food_preferences']),
              _buildChipSection('Visited Cities', _getVisitedCities(userData['visited_cities'])),
              const SizedBox(height: 16),
              _buildHeader('Travel History'),
              _buildUserInfoRow('Joined Akasa', userData['joined_akasa']),
            ],
          ),
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



// More Page
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'More Options Page Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// The page you navigate to (AnotherPage)
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Another Page"),
      ),
      body: const Center(
        child: Text("This is another page"),
      ),
    );
  }
}
