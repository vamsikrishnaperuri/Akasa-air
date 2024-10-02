class Booking {
  final String bookingReference;
  final PassengerDetails passengerDetails;
  final FlightDetails flightDetails;
  final String bookingStatus;
  final PaymentDetails paymentDetails;
  final String? specialRequests;
  final LoyaltyProgram? loyaltyProgram;

  Booking({
    required this.bookingReference,
    required this.passengerDetails,
    required this.flightDetails,
    required this.bookingStatus,
    required this.paymentDetails,
    this.specialRequests,
    this.loyaltyProgram,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingReference: json['bookingReference'],
      passengerDetails: PassengerDetails.fromJson(json['passengerDetails']),
      flightDetails: FlightDetails.fromJson(json['flightDetails']),
      bookingStatus: json['bookingStatus'],
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      specialRequests: json['specialRequests'],
      loyaltyProgram:
      json['loyaltyProgram'] != null ? LoyaltyProgram.fromJson(json['loyaltyProgram']) : null,
    );
  }
}

class PassengerDetails {
  final String firstName;
  final String lastName;

// Removed dateOfBirth and contact details for simplification

  PassengerDetails({
    required this.firstName,
    required this.lastName,
    // Initialize dateOfBirth and contact details if needed
//   required this.dateOfBirth,
//   required this.contactDetails,
  });

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      firstName: json['firstName'],
      lastName: json['lastName'],
      // Initialize dateOfBirth and contact details if needed
//     dateOfBirth : json['dateOfBirth'],
//     contactDetails : ContactDetails.fromJson(json['contactDetails']),
    );
  }
}

class FlightDetails {
  final String flightNumber;
  final Location departure;
  final Location arrival;

  FlightDetails({
    required this.flightNumber,
// Removed flightClass and seatNumber for simplification
    required this.departure,
    required this.arrival,
// Initialize flightClass and seatNumber if needed
// required this.flightClass,
// required this.seatNumber,
  });

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
      flightNumber : json['flightNumber'],
      departure : Location.fromJson(json['departure']),
      arrival : Location.fromJson(json['arrival']),
// Initialize flightClass and seatNumber if needed
// flightClass : json['flightClass'],
// seatNumber : json['seatNumber'],
    );
  }
}

class Location {
  final String city;

  Location({
    required this.city,
// Removed airport, country, and dateTime for simplification
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city : json['city'],
// Initialize airport, country, and dateTime if needed
// airport : json['airport'],
// country : json['country'],
// dateTime : json['dateTime'],
    );
  }
}

class PaymentDetails {
// Removed paymentMethod for simplification
  final String amount;
  final String currency;
  final String paymentStatus;

  PaymentDetails({
    required this.amount,
    required this.currency,
// Initialize paymentMethod if needed
    required this.paymentStatus,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      amount : json['amount'],
      currency : json['currency'],
      paymentStatus : json['paymentStatus'],
    );
  }
}

class LoyaltyProgram {
  final String programName;

  LoyaltyProgram({
    required this.programName,
// Removed membershipNumber and pointsEarned for simplification
  });

  factory LoyaltyProgram.fromJson(Map<String, dynamic> json) {
    return LoyaltyProgram(
      programName : json['programName'],
// Initialize membershipNumber and pointsEarned if needed
    );
  }
}