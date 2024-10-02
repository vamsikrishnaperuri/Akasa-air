import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/button.dart';
import '../components/squaretile.dart';
import '../components/textfields.dart';
import 'Login.dart';
import 'Services/auth.dart';
import 'main.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});


  @override
  State<SignupScreen> createState() => _State();
}

class _State extends State<SignupScreen> {

  // String email="",password="",name="";
  final TextEditingController usernamecontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController emaildcontroller = new  TextEditingController();
  bool isLoading = false;

  // void signupUser() async{
  //   // set is loading to true.
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // signup user using our authmethod
  //   String res = await AuthServices().signupUser(
  //       name: usernamecontroller.text,
  //       email: emaildcontroller.text,
  //       password: passwordcontroller.text
  //   );
  //   print("<<<-----------------------------------------------: $res--------------------------------------------->>>");
  //   if(res == "Successfully executed"){
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
  //   }else{
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.orangeAccent,
  //         content: Text(
  //           "Account Already exists",
  //           style: TextStyle(fontSize: 18.0),
  //         )));
  //   }
  // }
  void signupUser() {
    var username = usernamecontroller.text;
    var email = emaildcontroller.text;
    var password = passwordcontroller.text;
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
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
                  const Text("Sign Up",
                    style: TextStyle(
                      color: Color(0xFF6F2596),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 25),

                  //username
                  Mytextfield(
                    controller: usernamecontroller, hinttxt: 'Username', obscuretxt: false,

                  ),
                  const SizedBox(height: 10),
                  //password
                  Mytextfield(
                    controller: emaildcontroller, hinttxt: 'Email', obscuretxt: false ,
                  ),

                  const SizedBox(height: 10),
                  //password
                  Mytextfield(
                    controller: passwordcontroller, hinttxt: 'Password', obscuretxt: true ,
                  ),

                  const SizedBox(height: 20),

                  //signin button
                  // SignupButton(
                  //     onTap: signupuser
                  // ),

                  MyButtons(
                    onTap: signupUser,
                    text: "Sign Up",
                  ),


                  const SizedBox(height:20),

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
                      Text('Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
                        },
                        child: const Text('Login',
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

