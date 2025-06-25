import 'package:sasy/Screens/Mainscreen.dart';
import 'package:flutter/material.dart';

class first_UI extends StatelessWidget {
  const first_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Text(
                "Smart \nBMI Calculater",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Accurately calculate your Body Mass Index and your daily calories intake. With advice on how to lose weight and maintain a healthy lifestyle. ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Flexible(
                child: Image.asset(
                  "lib/Images/Burgers/BMI.png",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
      
                    Spacer(),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
