import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final controller;
  final String hinttxt;
  final bool obscuretxt;

  const Mytextfield({super.key, this.controller, required this.hinttxt, required this.obscuretxt,});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value){
            if(value==null||value.isEmpty){
              return 'Please fill all fields';
            }
            return null;
          },
          controller: controller,
          obscureText: obscuretxt,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber.shade900),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hinttxt,
            hintStyle: const TextStyle(color: Colors.black26),
          ),
        ),
      ),

    );

  }
}
