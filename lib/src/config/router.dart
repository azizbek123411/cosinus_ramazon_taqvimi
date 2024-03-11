import 'package:flutter/material.dart';

class AppRouter {
  static void go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static void id(BuildContext context, String id) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      id,
          (Route<dynamic> route) => false,
    );
  }

  static void close(context) => Navigator.pop(context);
}