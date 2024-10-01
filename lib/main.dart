import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scheme/splash%20screen.dart';
import 'EditProfile.dart';
import 'Login.dart';
import 'Myprofile.dart';
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
