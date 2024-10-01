import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String selectedGender = 'Male';
  String selectedCountry = 'India';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
        title: const Text(
          'Edit my profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Add functionality to change the profile photo here
                    },
                    child: const Text(
                      'Change photo',
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Input Fields
            buildTextField('First Name', 'Harsha'),
            buildTextField('Last Name', 'Bellala'),

            // Gender Section using Chips
            const SizedBox(height: 16),
            buildLabel('Gender'),
            Wrap(
              spacing: 8.0,
              children: ['Male', 'Female', 'Other'].map((gender) {
                return ChoiceChip(
                  label: Text(gender),
                  selected: selectedGender == gender,
                  onSelected: (bool isSelected) {
                    setState(() {
                      selectedGender = gender;
                    });
                  },
                  selectedColor: Color(0xFFFF6600),
                  backgroundColor: Colors.grey.shade300,
                  labelStyle: TextStyle(
                    color: selectedGender == gender ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Date of Birth Picker
            buildLabel('Date Of Birth (Optional)'),
            InkWell(
              onTap: () {
                _selectDate(context); // Open DatePicker
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today, color: Color(0xFFFF6600)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Country Dropdown
            buildLabel('Country'),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              items: <String>['India', 'USA', 'Canada', 'Australia'].map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue!;
                });
              },
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFF6600)),
            ),
            const SizedBox(height: 16),

            // Additional fields
            buildTextField('City', 'Visakhapatnam'),
            buildTextField('State', 'Andhra Pradesh'),
            buildTextField('Address', 'Your address here'),

            // Buttons
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle Cancel
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Update
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6600),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for TextFields
  Widget buildTextField(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: placeholder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Helper widget for section labels
  Widget buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  // DatePicker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
