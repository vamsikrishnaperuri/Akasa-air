// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthServices {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   Future<String> signupUser({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     if (name.isEmpty || email.isEmpty || password.isEmpty) {
//       return "Error: Invalid input parameters";
//     }
//
//     String res = "An error occurred"; // Default error message
//
//     try {
//       // Create a new user with email and password
//       UserCredential userCredential = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//
//       if (userCredential.user != null) {
//         String uid = userCredential.user!.uid;
//         print("User ID: $uid");
//
//         // Add user details to Firestore under 'users' collection
//         await _firestore.collection("users").doc(uid).set({
//           'name': name,
//           'email': email,
//           'uid': uid,
//         });
//
//         print("Successfully added to Firestore");
//         res = "Successfully executed";
//       } else {
//         res = "User creation failed: user is null";
//         print("Error: User creation failed");
//       }
//     } catch (e) {
//       // Log detailed error message
//       res = "Error: ${e.toString()}";
//       print("Error occurred: $res");
//     }
//
//     print("<<<-----------------------------------------------: $res--------------------------------------------->>>");
//     return res;
//   }
// }