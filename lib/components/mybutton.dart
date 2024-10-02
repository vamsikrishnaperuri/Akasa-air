import 'package:flutter/material.dart';

import '../main.dart';



class Mybutton extends StatelessWidget {

  late final Function()? onTap;
  final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: const Size(220,50), backgroundColor: Colors.amber[900],
    // primary: Colors.amber[900],
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))),

  );


  Mybutton({required void Function() onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonPrimary,
      onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      },
      child: const Text("Sign In",
        style: TextStyle(color: Colors.white),),

    );
  }
}