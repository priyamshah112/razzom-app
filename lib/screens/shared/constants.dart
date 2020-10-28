import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Color(0xFFFFFFFF),
  ),
  fillColor: Color(0xFF0C1A24),
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF0C1A24),
    ),
    borderRadius: const BorderRadius.all(
      const Radius.circular(20.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF0C1A24),
    ),
    borderRadius: const BorderRadius.all(
      const Radius.circular(20.0),
    ),
  ),
);
