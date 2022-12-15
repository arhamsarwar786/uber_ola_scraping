import 'package:flutter/material.dart';

snackBar(context, text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(milliseconds: 500),
  ));
}