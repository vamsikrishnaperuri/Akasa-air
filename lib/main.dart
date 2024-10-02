import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:scheme/splash%20screen.dart';
import 'EditProfile.dart';
import 'Login.dart';
import 'Myprofile.dart';
import 'chatbot.dart';  // Make sure to define this file properly
import 'details_screen.dart';
import 'userprofile.dart';  // Make sure to define this file properly
import 'user.dart'; // Ensure you import the user model
import 'details_screen.dart'; // Import the details screen
import 'package:http/http.dart' as http;

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
        '/': (context) => const Splash(),
        '/login': (context) => Loginpage(),
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
        automaticallyImplyLeading: false,
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
          // Chip for current city
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: const Chip(
              label: Text(
                'Current City : Delhi',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Color(0xFFFF6600), // Chip color (Purple)
            ),
          ),

          // Image with text overlay
          Stack(
            children: [
              // Background image
              Container(
                width: double.infinity,
                height: 150, // Adjust height as needed
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('lib/images/splash_web.jpg'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Overlay with text
              Positioned(
                left: 16, // Adjust position as needed
                top: 16, // Adjust position as needed
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent background for contrast
                  padding: const EdgeInsets.all(8.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exclusive flight deals\n on AkasaAir.com\n and App',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Text(
                      //   'Login now and get up to 20% off. Use code: FLYMORE',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
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
          const SizedBox(height: 20),
          // Add more UI components here as needed
          _buildOptionButtons(),
          const SizedBox(height: 20),
          _buildRecentSearches(),
        ],
      ),
    );
  }

  // Method to build additional option buttons
  Widget _buildOptionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton('Check-in', Icons.check_circle),
        _buildButton('Flight Status', Icons.flight_takeoff),
        _buildButton('Manage', Icons.manage_accounts),
      ],
    );
  }

  // Helper method to create individual buttons
  Widget _buildButton(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3), // Shadow for depth effect
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6F2596), size: 28), // Purple Icon
          SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Method to build recent searches section
  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your recent searches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRecentSearchItem('BOM', 'DEL'),
            _buildRecentSearchItem('BOM', 'HYD'),
          ],
        ),
      ],
    );
  }

  // Helper method to create recent search items
  Widget _buildRecentSearchItem(String from, String to) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // Light Grey background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$from → $to',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}

// Booking Page
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/screen2.jpeg'), // Update the path to your image
            fit: BoxFit.cover, // Adjust the fit as necessary (cover, contain, etc.)
          ),
        ),
        child: const Center(
          child: Text(
            'Booking Page',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white, // Change the color to ensure visibility
            ),
          ),
        ),
      ),
    );
  }
}
// Profile Page

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              onTap: () {
                // Action for profile click
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: const AssetImage('lib/images/user_profilelogog.png'), // Profile image
                backgroundColor: Colors.orange.shade100,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Signed up since May, 14',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customTextButton('Change password'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage()),
                      );
                    },
                    child: const Text(
                      'Edit my profile',
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  profileOption(Icons.airplane_ticket, 'My bookings', () {}),
                  profileOption(Icons.person, 'My profile', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage()),
                    );
                  }),
                  profileOption(Icons.tune, 'My preferences', () {}),
                  profileOption(Icons.group, 'Saved travellers', () {}),
                  profileOption(Icons.business, 'Business profile', () {}),
                  profileOption(Icons.logout, 'Logout', () {}),
                ],
              ),
              const SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.grey.shade300),
              const SizedBox(height: 10),
              const Text(
                'Follow us on social media',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialMediaIcon(Icons.facebook, Colors.orange),
                  socialMediaIcon(Icons.linked_camera, Colors.orange),
                  socialMediaIcon(Icons.video_collection, Colors.orange),
                  socialMediaIcon(Icons.image, Colors.orange),
                  socialMediaIcon(Icons.business, Colors.orange),
                ],
              ),
              SizedBox(height: 30),
              Divider(thickness: 1, color: Colors.grey.shade300),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call, color: Colors.black),
                    label: Text('Call us', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.help, color: Colors.black),
                    label: Text('FAQs', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextButton(String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Colors.purple, fontSize: 16),
      ),
    );
  }

  Widget profileOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, // Set a fixed height for the profile option
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5, // Reduced blur radius for a subtle shadow
              offset: Offset(0, 2), // Reduced offset for the shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange, size: 30), // Reduced icon size
            SizedBox(height: 8), // Reduced space between icon and text
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.black87), // Reduced text size
            ),
          ],
        ),
      ),
    );
  }

  Widget socialMediaIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8), // Adjusted padding for a smaller circle
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24), // Reduced icon size for social media
    );
  }

}



// More Page
class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<Booking> bookings = [];
  bool _isLoading = true;

  Future<void> fetchBookings() async {
    try {
      final response = await http.get(Uri.parse('http://ec2-13-60-174-218.eu-north-1.compute.amazonaws.com/bookings/?email=harshasrikasyap807@gmail.com'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          bookings = jsonData.map((item) => Booking.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching bookings: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Bookings"),
        backgroundColor: Color(0xFFFF6600), // Primary Orange Color
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
          ? const Center(child: Text("No bookings found"))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4,
            child: ListTile(
              title: Text('Booking: ${bookings[index].bookingReference}', style: TextStyle(color: Color(0xFF000000))),
              subtitle: Text(
                'Passenger: ${bookings[index].passengerDetails.firstName} | Flight: ${bookings[index].flightDetails.flightNumber} | Status: ${bookings[index].bookingStatus}',
                style: TextStyle(color: Color(0xFF666666)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(booking: bookings[index]),
                  ),
                );
              },
            ),
          );
        },
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
