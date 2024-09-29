import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List to store chat messages
  List<Map<String, String>> messages = [
    {'role': 'bot', 'text': 'Welcome to Akasa AI! How can I assist you today?'}
  ];

  // Controller to handle input text
  final TextEditingController _controller = TextEditingController();

  String? name;
  String? fromCity;
  String? toCity;
  DateTime? journeyDate;
  String? travelClass;
  String? seatPreference;

  // Different stages of the chat
  int chatStage = 0;

  // Function to handle user input and bot responses
  void _handleSendMessage() {
    String userInput = _controller.text.trim();

    if (userInput.isNotEmpty || chatStage == 3 || chatStage == 4 || chatStage == 5) {
      setState(() {
        if (chatStage != 3 && chatStage != 4 && chatStage != 5) {
          // Add user's message to chat if it's not a selection stage
          messages.add({'role': 'user', 'text': userInput});
        }

        // Bot responses based on the chat stage
        switch (chatStage) {
          case 0:
          // name = userInput;
            messages.add({'role': 'bot', 'text': 'Can I know your name please?'});
            chatStage++;
            break;
          case 1:
            name = userInput;
            // fromCity = userInput;
            messages.add({'role': 'bot', 'text': 'Travel from?'});
            chatStage++;
            break;
          case 2:
            fromCity = userInput;
            // toCity = userInput;
            messages.add({'role': 'bot', 'text': 'Destination?'});
            chatStage++;
            break;
          case 3:
            toCity = userInput;
            _showDatePicker();
            break;
          case 4:
            _showTravelClassOptions();
            break;
          case 5:
            _showSeatPreferenceOptions();
            break;
          case 6:
            _confirmBooking();
            break;
          case 7:
            if (userInput.toLowerCase() == 'yes') {
              messages.add({
                'role': 'bot',
                'text':
                'Your booking is confirmed! Thank you for using Akasa AI!'
              });
            } else {
              messages.add({
                'role': 'bot',
                'text': 'Booking not confirmed. Let me know if you need anything else.'
              });
            }
            chatStage = 0; // Reset chat stage after confirmation
            break;
        }
      });
      _controller.clear(); // Clear the input after sending
    }
  }

  // Function to show the date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          journeyDate = selectedDate;
          messages.add({
            'role': 'bot',
            'text': 'Date of Journey: ${DateFormat('dd-MM-yyyy').format(journeyDate!)}'
          });
          chatStage++; // Move to the next stage
        });
        _handleSendMessage(); // Automatically trigger the next bot response after date selection
      }
    });
  }

  // Function to show travel class options with heading
  void _showTravelClassOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Travel Class',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Economy'),
                  leading: Radio<String>(
                    value: 'Economy',
                    groupValue: travelClass,
                    onChanged: (String? value) {
                      setModalState(() {
                        travelClass = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Business'),
                  leading: Radio<String>(
                    value: 'Business',
                    groupValue: travelClass,
                    onChanged: (String? value) {
                      setModalState(() {
                        travelClass = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (travelClass != null) {
                      setState(() {
                        messages.add({
                          'role': 'bot',
                          'text': 'Selected class: $travelClass'
                        });
                        chatStage++;
                        Navigator.pop(context); // Close modal
                        _handleSendMessage(); // Automatically trigger next bot response after class selection
                      });
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to show seat preference options with heading
  void _showSeatPreferenceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Seat Preference',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Window'),
                  leading: Radio<String>(
                    value: 'Window',
                    groupValue: seatPreference,
                    onChanged: (String? value) {
                      setModalState(() {
                        seatPreference = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Aisle'),
                  leading: Radio<String>(
                    value: 'Aisle',
                    groupValue: seatPreference,
                    onChanged: (String? value) {
                      setModalState(() {
                        seatPreference = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Middle'),
                  leading: Radio<String>(
                    value: 'Middle',
                    groupValue: seatPreference,
                    onChanged: (String? value) {
                      setModalState(() {
                        seatPreference = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (seatPreference != null) {
                      setState(() {
                        messages.add({
                          'role': 'bot',
                          'text': 'Seat preference: $seatPreference'
                        });
                        chatStage++;
                        Navigator.pop(context); // Close modal
                        _handleSendMessage(); // Automatically trigger next bot response after seat selection
                      });
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to confirm booking
  void _confirmBooking() {
    setState(() {
      // Ensure the correct data is displayed in the confirmation message
      messages.add({
        'role': 'bot',
        'text':
        'Please confirm your booking:\nName: $name\nFrom: $fromCity\nTo: $toCity\nDate: ${DateFormat('dd-MM-yyyy').format(journeyDate!)}\nClass: $travelClass\nSeat Preference: $seatPreference\n\nDo you want to confirm? (yes/no)'
      });
      chatStage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6600), // Orange color
        title: const Text('Akasa AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['role'] == 'user';
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
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
              borderRadius: BorderRadius.circular(20.0), // Rounded edges
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 5, // Blur radius for elevation
                  offset: const Offset(0, 3), // Offset of the shadow
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
                  icon: const Icon(Icons.send, color: Color(0xFFFF6600)), // Orange color
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
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFFFF6600) : const Color(0xFFF0F0F0), // Orange for user, Light Grey for bot
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
          bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black, // White for user text, black for bot text
          fontSize: 16,
        ),
      ),
    );
  }
}
