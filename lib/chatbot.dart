import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> messages = [
    {'role': 'bot', 'text': 'Welcome to Akasa AI! How can I assist you today?'}
  ];

  final TextEditingController _controller = TextEditingController();
  String? sourceAirportCode;
  String? destinationAirportCode;
  String? flightNumber;
  String? flightDepartureTime;

  void _handleSendMessage() async {
    String userInput = _controller.text.trim();
    if (userInput.isNotEmpty) {
      setState(() {
        messages.add({'role': 'user', 'text': userInput});
      });
      _controller.clear();

      try {
        var response = await http.post(
          Uri.parse('http://ec2-13-60-174-218.eu-north-1.compute.amazonaws.com/chat'), // Update this URL if needed
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'message': userInput}),
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          _processResponse(data);
        } else {
          setState(() {
            messages.add({
              'role': 'bot',
              'text': 'Error: Unable to get a valid response from the server.'
            });
          });
        }
      } catch (e) {
        setState(() {
          messages.add({
            'role': 'bot',
            'text': 'Error: $e'
          });
        });
      }
    }
  }

  void _processResponse(Map<String, dynamic> data) {
    // Get the last entry in the history array
    var history = data['history'];
    if (history.isNotEmpty) {
      var lastEntry = history.last['msg'];
      String botResponse = lastEntry['response'];

      setState(() {
        messages.add({'role': 'bot', 'text': botResponse});

        // Extract necessary values for the banner
        sourceAirportCode = lastEntry['source_airport_code'] != "not-applicable" ? lastEntry['source_airport_code'] : null;
        destinationAirportCode = lastEntry['destination_airport_code'] != "not-applicable" ? lastEntry['destination_airport_code'] : null;

        // Check for flight information
        if (lastEntry['confirm-fn-fdep'] == "yes") {
          flightNumber = lastEntry['flightNumber'] != "not-applicable" ? lastEntry['flightNumber'] : null;
          flightDepartureTime = lastEntry['flight_departure_time'] != "not-applicable" ? lastEntry['flight_departure_time'] : null;
        } else {
          flightNumber = null;
          flightDepartureTime = null;
        }
      });
    }
  }

  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.orange[100], // Light orange background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (sourceAirportCode != null && destinationAirportCode != null)
            Text('${sourceAirportCode} ➔ ${destinationAirportCode}',
                style: const TextStyle(fontSize: 16)),
          if (flightNumber != null && flightDepartureTime != null)
            Text('Flight: $flightNumber at $flightDepartureTime',
                style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6600),
        title: const Text('Akasa AI Chat'),
      ),
      body: Column(
        children: [
          // Banner displaying source and destination or flight info
          _buildBanner(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['role'] == 'user';
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: ChatBubble(
                    text: messages[index]['text'] ?? '',
                    isUser: isUser,
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon:
                  const Icon(Icons.send, color: Color(0xFFFF6600)),
                  onPressed: _handleSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      constraints:
      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: BoxDecoration(
        color:
        isUser ? const Color(0xFFFF6600) : const Color(0xFFF0F0F0),
        borderRadius:
        BorderRadius.only(topLeft: Radius.circular(16), topRight:
        Radius.circular(16), bottomLeft:
        isUser ? Radius.circular(16) : Radius.circular(0), bottomRight:
        isUser ? Radius.circular(0) : Radius.circular(16)),
      ),
      child:
      Text(text, style:
      TextStyle(color:isUser ? Colors.white : Colors.black,fontSize:
      16)),
    );
  }
}