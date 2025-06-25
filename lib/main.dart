import 'package:sasy/Screens/First_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BMICAL());

class BMICAL extends StatefulWidget {
  const BMICAL({super.key});

  @override
  State<BMICAL> createState() => _BMICALState();
}

class _BMICALState extends State<BMICAL> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: first_UI()),
    );
  }
}
