
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scheme/register.dart';

import '../components/mybutton.dart';
import '../components/squaretile.dart';
import '../components/textfields.dart';
import 'package:info_popup/info_popup.dart';


class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // // String email="",password="";
  // final TextEditingController emailcontroller = TextEditingController();
  //
  // final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController(text: "harshasrikasyap807@gmail.com");

  final TextEditingController passwordcontroller = TextEditingController(text: "12345678");


  //sign user in
  // void signuserin() async{
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailcontroller.text,
  //     password: passwordcontroller.text,
  //   );
  // }
  void signuserin() {
    var email = emailcontroller.text;
    var password = passwordcontroller.text;
    if (email.isEmpty || password.isEmpty) {
      // Show an alert if any field is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("All fields are required!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        },
      );
    } else {
      // Navigate to another page if the fields are valid
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //logo

                  Center(
                    child: Image.asset('lib/images/signinvec.png',height: 200,width: 350,
                    ),
                  ),

                  //welcome
                  const Text("Sign In",
                    style: TextStyle(
                      color: Color(0xFFFF6600),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 25),

                  //username
                  Mytextfield(
                    controller: emailcontroller, hinttxt: 'Username', obscuretxt: false,

                  ),

                  const SizedBox(height: 10),
                  //password
                  Mytextfield(
                    controller: passwordcontroller, hinttxt: 'Password', obscuretxt: true ,
                  ),

                  const SizedBox(height: 10),

                  //forgotpassword
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  //signin button

                  Mybutton(onTap: signuserin),


                  const SizedBox(height:30),

                  //or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Or continue with",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  //google or apple
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Squaretile(imagepath: 'lib/images/google.png'),
                      SizedBox(width: 25),
                      Squaretile(imagepath: 'lib/images/apple.png'),
                    ],
                  ),

                  //not login then sign up

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                        },
                        child: const Text('Sign Up',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}