import 'package:flutter/material.dart';
import 'package:scheme/splash%20screen.dart';

import 'chatbot.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Set the initial route to splash screen
      routes: {
        '/': (context) => const Splash(),
        '/home': (context) => const HomeScreen(), // Define your home screen route
        '/anotherPage': (context) => const AnotherPage(), // Add your new page route here
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6600), // Orange
        title: const Text('Akasa Air'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top Banner
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

                // Book a flight section
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

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.flight_takeoff, color: Color(0xFF6F2596)), // Purple icon
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.check_circle_outline, color: Color(0xFF6F2596)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time, color: Color(0xFF6F2596)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.manage_accounts, color: Color(0xFF6F2596)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Positioned image in the bottom-right corner
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate with animation using PageRouteBuilder
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ChatScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Slide animation from right to left
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
                'assets/user-folder.png', // Replace with your image path
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6600), // Orange
        unselectedItemColor: Colors.grey,
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
