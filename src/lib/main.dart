import 'package:flutter/material.dart';
import "package:src/pages/field_page.dart";

void main() {
  runApp(
    MaterialApp(
      routes: {
        "/": (context) => Field()
      },
      theme: ThemeData(
        useMaterial3: false,
      ),
    )
  );
}
