import 'package:sasy/Extras/Age.dart'; 
import 'package:sasy/Extras/height_weidth.dart';
import 'package:sasy/Screens/Resultscreen.dart';
import 'package:sasy/Extras/Exercise_level.dart';
import 'package:flutter/material.dart';
import 'package:sasy/Extras/Text_after_result.dart'; 
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State variables to hold user selections
  EXle _selectedLevel = exercises[2]; // Default to Moderate
  Gender selectedGender = Gender.male;
  double selectedHeight = 1.70; // Default height in meters
  double selectedWeight = 70.0; // Default weight in kilograms
  int selectedAge = 25; // Default age

  @override
  Widget build(BuildContext context) {
    // Returns the UI content to be placed inside the Scaffold from main.dart
    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(16.0), child: _UI())),);
  }

  // Builds the main column layout for the screen
  Widget _UI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Smart\nBMI Calculator", // Title
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: 20),

        //  Gender toggle 
        _buildGenderToggle(),
        const SizedBox(height: 20),

        //  Age picker 
        const Text(
          "Age",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        AgePicker(
          initialAge: selectedAge,
          onChanged: (newAge) {
            setState(() {
              selectedAge = newAge;
            });
          },
        ),
        const SizedBox(height: 20),

        // --- Height & Weight picker ---
        // Use the updated BMIPicker with state management and centering
        BMIPicker(
          initialHeight: selectedHeight,
          initialWeight: selectedWeight,
          onHeightChanged: (newHeight) {
            setState(() {
              selectedHeight = newHeight;
            });
          },
          onWeightChanged: (newWeight) {
            setState(() {
              selectedWeight = newWeight;
            });
          },
        ),
        const SizedBox(height: 20),

        // --- Exercise level dropdown ---
        const Text(
          "Exercise level",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        const SizedBox(height: 8),
        // Use the updated ExerciseLevelCard with state management
        ExerciseLevelCard(
          selectedLevel: _selectedLevel,
          onChanged: (EXle? newLevel) {
            if (newLevel != null) {
              setState(() => _selectedLevel = newLevel);
            }
          },
        ),

        const Spacer(), // Pushes the button to the bottom
        // --- Calculate button ---
        ElevatedButton(
          style: ElevatedButton.styleFrom(
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
          onPressed: () {
            print(
              "Calculating with: H=${selectedHeight.toStringAsFixed(2)}m, W=${selectedWeight.toStringAsFixed(1)}kg, Gender=$selectedGender, Level=${_selectedLevel.level}, Age=$selectedAge",
            );

            // Instantiate the calculator
            final calc = BMICalculator(
              height: selectedHeight,
              weight: selectedWeight,
              gender: selectedGender,
              age: selectedAge,
              exerciseLevel: _selectedLevel,
            );

            // Calculate BOTH standard BMI and TDEE
            final bmi = calc.calculateStandardBMI();
            final tdee = calc.calculateTDEE();

            // Navigate to the result screen, passing BOTH values
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => FullResult(
                      bmiValue: bmi, // Pass standard BMI
                      tdeeValue: tdee, // Pass TDEE
                    ),
              ),
            );
          },
          child: const Text("Calculate", style: TextStyle(color: Colors.white),), // Updated button text
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Helper widget for building the Gender Toggle UI
  Widget _buildGenderToggle() {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        // Considers the Padding around _UI
        final outerPadding = 16.0 * 2; 
        // Padding inside the toggle container
        final innerPadding = 6.0 * 2; 
        final containerWidth = screenWidth - outerPadding;
        final thumbWidth = (containerWidth - innerPadding) / 2;

        // Prevent negative width on very small screens
        if (thumbWidth <= 0) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              // Animated sliding background
              AnimatedAlign(
                alignment:
                    selectedGender == Gender.male
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Container(
                  width: thumbWidth,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              // Row containing the two tappable options
              Row(
                children: [
                  _buildGenderOption(
                    Gender.male,
                    Icons.male,
                    'Male',
                    thumbWidth,
                  ),
                  _buildGenderOption(
                    Gender.female,
                    Icons.female,
                    'Female',
                    thumbWidth,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper widget for building each gender option (Male/Female)
  Widget _buildGenderOption(
    Gender gender,
    IconData icon,
    String label,
    double width,
  ) {
    final isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedGender = gender),
        behavior: HitTestBehavior.opaque, // Make the whole area tappable
        child: Container(
          width: width,
          // Center the content (icon + text) vertically
          child: Center(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center horizontally
              mainAxisSize: MainAxisSize.min, // Take minimum horizontal space
              children: [
                Icon(icon, color: isSelected ? Colors.white : Colors.black),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

