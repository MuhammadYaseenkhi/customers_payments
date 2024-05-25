
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final FocusNode focusNode;
  final bool obscureText;
  final Icon prefixIcon;
  final Function(String)? onChanged;

  const MyTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.focusNode,
        required this.obscureText,
        required this.prefixIcon,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: HexColor("#4f4f4f"),
      onChanged: onChanged,
      focusNode: focusNode,
      decoration: InputDecoration(
        //errorStyle: const TextStyle(height: 0, fontSize: 10),
        contentPadding: const EdgeInsets.symmetric(vertical: 25),
        hintText: hintText,
        fillColor: HexColor("#f0f3f1"),
        // contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: HexColor("#8d8d8d"),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(00),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: HexColor("#4f4f4f"),
        filled: true,
      ),
    );
  }
}
