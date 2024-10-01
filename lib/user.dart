// user.dart
class User {
  final String id;
  final String bookingReference;
  final PassengerDetails passengerDetails;
  final FlightDetails flightDetails;
  final String bookingStatus;
  final PaymentDetails paymentDetails;
  final String specialRequests;
  final LoyaltyProgram loyaltyProgram;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.bookingReference,
    required this.passengerDetails,
    required this.flightDetails,
    required this.bookingStatus,
    required this.paymentDetails,
    required this.specialRequests,
    required this.loyaltyProgram,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      bookingReference: json['bookingReference'],
      passengerDetails: PassengerDetails.fromJson(json['passengerDetails']),
      flightDetails: FlightDetails.fromJson(json['flightDetails']),
      bookingStatus: json['bookingStatus'],
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      specialRequests: json['specialRequests'],
      loyaltyProgram: LoyaltyProgram.fromJson(json['loyaltyProgram']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class PassengerDetails {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String passportNumber;
  final String nationality;
  final ContactDetails contactDetails;

  PassengerDetails({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    required this.contactDetails,
  });

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      passportNumber: json['passportNumber'],
      nationality: json['nationality'],
      contactDetails: ContactDetails.fromJson(json['contactDetails']),
    );
  }
}

class ContactDetails {
  final String email;
  final String phone;

  ContactDetails({
    required this.email,
    required this.phone,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class FlightDetails {
  final String flightNumber;
  final String airline;
  final Departure departure;
  final Arrival arrival;
  final String flightClass;
  final String seatNumber;

  FlightDetails({
    required this.flightNumber,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.flightClass,
    required this.seatNumber,
  });

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
      flightNumber: json['flightNumber'],
      airline: json['airline'],
      departure: Departure.fromJson(json['departure']),
      arrival: Arrival.fromJson(json['arrival']),
      flightClass: json['flightClass'],
      seatNumber: json['seatNumber'],
    );
  }
}

class Departure {
  final String airport;
  final String city;
  final String country;
  final String dateTime;

  Departure({
    required this.airport,
    required this.city,
    required this.country,
    required this.dateTime,
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      airport: json['airport'],
      city: json['city'],
      country: json['country'],
      dateTime: json['dateTime'],
    );
  }
}

class Arrival {
  final String airport;
  final String city;
  final String country;
  final String dateTime;

  Arrival({
    required this.airport,
    required this.city,
    required this.country,
    required this.dateTime,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) {
    return Arrival(
      airport: json['airport'],
      city: json['city'],
      country: json['country'],
      dateTime: json['dateTime'],
    );
  }
}

class PaymentDetails {
  final double amount;
  final String currency;
  final String paymentMethod;
  final String paymentStatus;
  final String paymentDate;

  PaymentDetails({
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      amount: json['amount'],
      currency: json['currency'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      paymentDate: json['paymentDate'],
    );
  }
}

class LoyaltyProgram {
  final String programName;
  final String membershipNumber;
  final int pointsEarned;

  LoyaltyProgram({
    required this.programName,
    required this.membershipNumber,
    required this.pointsEarned,
  });

  factory LoyaltyProgram.fromJson(Map<String, dynamic> json) {
    return LoyaltyProgram(
      programName: json['programName'],
      membershipNumber: json['membershipNumber'],
      pointsEarned: json['pointsEarned'],
    );
  }
}
