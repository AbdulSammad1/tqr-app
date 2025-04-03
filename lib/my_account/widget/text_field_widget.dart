import 'package:flutter/material.dart';

import '../../utils/constants.dart';



class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final Color color;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: color)),
                 enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color, width: 2),
                borderRadius: BorderRadius.circular(12)),
                prefixIcon: icon,
            labelText: hintText,
            ),


      ),
    );
  }
}


class PhoneTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon1;
  final Icon icon2;
  final Color color;
  final TextInputType textInputType;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon1,
    required this.color,
    required this.icon2,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        cursorColor: Constants.PRIMARY_COLOR,
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Constants.SECONDRY_COLOR),
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon1,
                Container(margin: EdgeInsets.only(bottom: 2.6), child: Text('+92', style: TextStyle(fontSize: 17,),)), 
                SizedBox(width:3)
              ],
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color, width: 2),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color, width: 2),
                borderRadius: BorderRadius.circular(12)),
            labelText: hintText,
            prefixStyle: const TextStyle(fontSize: 16),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: icon2,
            )),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final Icon icon1;
  final Icon icon2;
  final Icon icon3;
  final Color color;
  final TextInputType textInputType;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon1,
    required this.color,
    required this.icon2,
    required this.textInputType,
    required this.icon3,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.black),
        cursorColor: Constants.PRIMARY_COLOR,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: _obscureText,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            prefixIcon: widget.icon1,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.color, width: 2),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.color, width: 2),
                borderRadius: BorderRadius.circular(12)),
            labelText: widget.hintText,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: _obscureText ? widget.icon2 : widget.icon3,
            )),

      
      ),
    );
  }
}
