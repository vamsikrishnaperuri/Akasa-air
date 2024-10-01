// details_screen.dart
import 'package:flutter/material.dart';
import 'user.dart';

class DetailsScreen extends StatelessWidget {
  final User user;

  const DetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Passenger Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Name: ${user.passengerDetails.firstName} ${user.passengerDetails.lastName}'),
            Text('DOB: ${user.passengerDetails.dateOfBirth}'),
            Text('Passport No: ${user.passengerDetails.passportNumber}'),
            Text('Nationality: ${user.passengerDetails.nationality}'),
            Text('Email: ${user.passengerDetails.contactDetails.email}'),
            Text('Phone: ${user.passengerDetails.contactDetails.phone}'),
            SizedBox(height: 20),
            Text('Flight Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Flight Number: ${user.flightDetails.flightNumber}'),
            Text('Airline: ${user.flightDetails.airline}'),
            Text('Departure: ${user.flightDetails.departure.city} (${user.flightDetails.departure.airport})'),
            Text('Arrival: ${user.flightDetails.arrival.city} (${user.flightDetails.arrival.airport})'),
            Text('Class: ${user.flightDetails.flightClass}'),
            Text('Seat: ${user.flightDetails.seatNumber}'),
            SizedBox(height: 20),
            Text('Booking Status: ${user.bookingStatus}'),
            Text('Amount Paid: ${user.paymentDetails.currency} ${user.paymentDetails.amount}'),
            Text('Payment Method: ${user.paymentDetails.paymentMethod}'),
            Text('Special Requests: ${user.specialRequests}'),
            Text('Loyalty Program: ${user.loyaltyProgram.programName}'),
          ],
        ),
      ),
    );
  }
}
