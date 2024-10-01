import 'dart:convert';

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context){
    return Scaffold();
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
  const MorePage({super.key});

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // Sample JSON data
  final List<User> users = [
    User.fromJson({
      "_id": "66f9c5bd2c411723103e3e2b",
      "bookingReference": "BR123456756",
      "passengerDetails": {
        "firstName": "Harsha",
        "lastName": "Bellala",
        "dateOfBirth": "1990-05-15",
        "passportNumber": "A12345678",
        "nationality": "Indian",
        "contactDetails": {
          "email": "harshasrikasyap807@gmail.com",
          "phone": "+919876543210"
        }
      },
      "flightDetails": {
        "flightNumber": "AK123",
        "airline": "Akasa Air",
        "departure": {
          "airport": "DEL",
          "city": "Delhi",
          "country": "India",
          "dateTime": "2024-10-10T14:30:00"
        },
        "arrival": {
          "airport": "BOM",
          "city": "Mumbai",
          "country": "India",
          "dateTime": "2024-10-10T17:30:00"
        },
        "flightClass": "Economy",
        "seatNumber": "12A"
      },
      "bookingStatus": "Confirmed",
      "paymentDetails": {
        "amount": 5000.0,
        "currency": "INR",
        "paymentMethod": "Credit Card",
        "paymentStatus": "Paid",
        "paymentDate": "2024-09-01"
      },
      "specialRequests": "Vegetarian meal",
      "loyaltyProgram": {
        "programName": "Akasa Air Miles",
        "membershipNumber": "AA12345",
        "pointsEarned": 100
      },
      "createdAt": "2024-09-30",
      "updatedAt": "2024-09-30"
    }),
    User.fromJson({
      "_id": "66f9c5bd2c411723103e3e2c",
      "bookingReference": "BR123456757",
      "passengerDetails": {
        "firstName": "Aditi",
        "lastName": "Sharma",
        "dateOfBirth": "1985-08-22",
        "passportNumber": "B98765432",
        "nationality": "Indian",
        "contactDetails": {
          "email": "aditi.sharma@example.com",
          "phone": "+919876543211"
        }
      },
      "flightDetails": {
        "flightNumber": "AK124",
        "airline": "Akasa Air",
        "departure": {
          "airport": "DEL",
          "city": "Delhi",
          "country": "India",
          "dateTime": "2024-10-12T10:00:00"
        },
        "arrival": {
          "airport": "BOM",
          "city": "Mumbai",
          "country": "India",
          "dateTime": "2024-10-12T12:30:00"
        },
        "flightClass": "Business",
        "seatNumber": "1A"
      },
      "bookingStatus": "Confirmed",
      "paymentDetails": {
        "amount": 15000.0,
        "currency": "INR",
        "paymentMethod": "Debit Card",
        "paymentStatus": "Paid",
        "paymentDate": "2024-09-15"
      },
      "specialRequests": "Gluten-free meal",
      "loyaltyProgram": {
        "programName": "Akasa Air Miles",
        "membershipNumber": "AA12346",
        "pointsEarned": 200
      },
      "createdAt": "2024-09-30",
      "updatedAt": "2024-09-30"
    }),
    User.fromJson({
      "_id": "66f9c5bd2c411723103e3e2d",
      "bookingReference": "BR123456758",
      "passengerDetails": {
        "firstName": "Ravi",
        "lastName": "Kumar",
        "dateOfBirth": "1992-11-05",
        "passportNumber": "C23456789",
        "nationality": "Indian",
        "contactDetails": {
          "email": "ravi.kumar@example.com",
          "phone": "+919876543212"
        }
      },
      "flightDetails": {
        "flightNumber": "AK125",
        "airline": "Akasa Air",
        "departure": {
          "airport": "DEL",
          "city": "Delhi",
          "country": "India",
          "dateTime": "2024-10-15T18:00:00"
        },
        "arrival": {
          "airport": "BOM",
          "city": "Mumbai",
          "country": "India",
          "dateTime": "2024-10-15T20:30:00"
        },
        "flightClass": "Economy",
        "seatNumber": "12B"
      },
      "bookingStatus": "Pending",
      "paymentDetails": {
        "amount": 5000.0,
        "currency": "INR",
        "paymentMethod": "Credit Card",
        "paymentStatus": "Pending",
        "paymentDate": "2024-09-20"
      },
      "specialRequests": "Window seat",
      "loyaltyProgram": {
        "programName": "Akasa Air Miles",
        "membershipNumber": "AA12347",
        "pointsEarned": 150
      },
      "createdAt": "2024-09-30",
      "updatedAt": "2024-09-30"
    }),
    User.fromJson({
      "_id": "66f9c5bd2c411723103e3e2e",
      "bookingReference": "BR123456759",
      "passengerDetails": {
        "firstName": "Priya",
        "lastName": "Singh",
        "dateOfBirth": "1995-01-12",
        "passportNumber": "D34567890",
        "nationality": "Indian",
        "contactDetails": {
          "email": "priya.singh@example.com",
          "phone": "+919876543213"
        }
      },
      "flightDetails": {
        "flightNumber": "AK126",
        "airline": "Akasa Air",
        "departure": {
          "airport": "DEL",
          "city": "Delhi",
          "country": "India",
          "dateTime": "2024-10-20T09:00:00"
        },
        "arrival": {
          "airport": "BOM",
          "city": "Mumbai",
          "country": "India",
          "dateTime": "2024-10-20T11:30:00"
        },
        "flightClass": "Economy",
        "seatNumber": "15C"
      },
      "bookingStatus": "Cancelled",
      "paymentDetails": {
        "amount": 5000.0,
        "currency": "INR",
        "paymentMethod": "Credit Card",
        "paymentStatus": "Refunded",
        "paymentDate": "2024-09-22"
      },
      "specialRequests": "No special meal",
      "loyaltyProgram": {
        "programName": "Akasa Air Miles",
        "membershipNumber": "AA12348",
        "pointsEarned": 80
      },
      "createdAt": "2024-09-30",
      "updatedAt": "2024-09-30"
    }),
    // Add more users as needed
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Bookings'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('${user.passengerDetails.firstName} ${user.passengerDetails.lastName}'),
              subtitle: Text('Booking Reference: ${user.bookingReference}'),
              trailing: Text(user.bookingStatus),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(user: user),
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
