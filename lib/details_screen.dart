import 'package:flutter/material.dart';
import 'user.dart';

class DetailScreen extends StatelessWidget {
  final Booking booking;

  DetailScreen({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        backgroundColor: Color(0xFFFF6600), // Primary Orange Color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booking Reference
              Text('Booking Reference:', style: TextStyle(fontWeight: FontWeight.bold)),
              Chip(label: Text(booking.bookingReference, style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFFFF6600)),
              SizedBox(height: 10),

              // Passenger Details
              Text('Passenger:', style: TextStyle(fontWeight: FontWeight.bold)),
              Chip(label: Text('${booking.passengerDetails.firstName} ${booking.passengerDetails.lastName}', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFFFF6600)),
              SizedBox(height: 10),

              // Flight Details
              Text('Flight Number:', style: TextStyle(fontWeight: FontWeight.bold)),
              Chip(label: Text(booking.flightDetails.flightNumber, style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFFFF6600)),
              SizedBox(height: 10),

              // Departure and Arrival Cities
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Departure City:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Chip(label:
                      Text(booking.flightDetails.departure.city, style:
                      TextStyle(color:
                      Colors.white)), backgroundColor:
                      Color(0xFFFF6600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children:
                    [
                      Text('Arrival City:', style:
                      TextStyle(fontWeight:
                      FontWeight.bold)),
                      Chip(label:
                      Text(booking.flightDetails.arrival.city, style:
                      TextStyle(color:
                      Colors.white)), backgroundColor:
                      Color(0xFFFF6600)),
                    ],
                  ),
                ],
              ),
              SizedBox(height:
              20),

              // Booking Status
              Text('Booking Status:', style:
              TextStyle(fontWeight:
              FontWeight.bold)),
              Chip(label:
              Text(booking.bookingStatus, style:
              TextStyle(color:
              Colors.white)), backgroundColor:
              Color(0xFFFF6600)),
              SizedBox(height:
              20),

              // Payment Details
              Divider(thickness:
              2),
              SizedBox(height:
              10),
              Text('Payment Details', style:
              TextStyle(fontSize:
              18, fontWeight:
              FontWeight.bold)),
              SizedBox(height:
              10),
              Row(children:[
                Expanded(child:
                Column(crossAxisAlignment:
                CrossAxisAlignment.start,
                    children:[
                      Row(children:[
                        Icon(Icons.attach_money, color:
                        Color(0xFF6F2596)), // Purple Icon Accent
                        SizedBox(width:
                        5),
                        RichText(text:
                        TextSpan(text:'Amount:', style:
                        TextStyle(color:
                        Colors.black), children:[
                          WidgetSpan(child:
                          SizedBox(width:
                          5)),
                          TextSpan(text:'${booking.paymentDetails.amount} ${booking.paymentDetails.currency}', style:
                          TextStyle(color:
                          Colors.black),)
                        ]))
                      ]),
                      Row(children:[
                        Icon(Icons.check_circle, color:
                        Color(0xFF6F2596)), // Purple Icon Accent
                        SizedBox(width:
                        5),
                        RichText(text:
                        TextSpan(text:'Payment Status:', style:
                        TextStyle(color:
                        Colors.black), children:[
                          WidgetSpan(child:SizedBox(width:
                          5)),
                          TextSpan(text: '${booking.paymentDetails.paymentStatus}', style: TextStyle(color: Colors.black)),
                        ]))
                      ]),
                    ]))
              ]),
              SizedBox(height :
              20),

              // Special Requests and Loyalty Program
              if (booking.specialRequests != null)
                Column(crossAxisAlignment : CrossAxisAlignment.start, children : [
                  Divider(thickness :2),
                  SizedBox(height :10),
                  RichText(text :
                  TextSpan(text :'Special Requests:', style :
                  TextStyle(fontWeight :FontWeight.bold , color :
                  Colors.black),children :[
                    WidgetSpan(child :
                    SizedBox(width :5)),
                    TextSpan(text : booking.specialRequests!,style :
                    TextStyle(color :Colors.black),)
                  ]))
                ]),
              if (booking.loyaltyProgram != null)
                Column(crossAxisAlignment :
                CrossAxisAlignment.start, children : [
                  Divider(thickness :
                  2),
                  SizedBox(height :10),
                  RichText(text :
                  TextSpan(text :'Loyalty Program:',style :
                  TextStyle(fontWeight :
                  FontWeight.bold , color :
                  Colors.black),children :[
                    WidgetSpan(child :
                    SizedBox(width :5)),
                    TextSpan(text :
                    booking.loyaltyProgram!.programName ,style :
                    TextStyle(color :Colors.black),)
                  ]))
                ]),
            ],
          ),
        ),
      ),
    );
  }
}