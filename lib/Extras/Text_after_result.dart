import 'package:sasy/Extras/Exercise_level.dart'; 

// enum Gender { male, female }
enum Gender { male, female }

class BMICalculator {
  final double height; // Height in meters (will be converted to cm for BMR)
  final double weight; // Weight in kilograms
  final Gender gender;
  final int age;
  final EXle exerciseLevel; // The EXle object


  BMICalculator({
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
    required this.exerciseLevel,
  });

  /// Calculates Basal Metabolic Rate (BMR) using Mifflin-St Jeor equation.
  double calculateBMR() {
    // Convert height from meters to centimeters for the formula
    double heightInCm = height * 100;

    if (gender == Gender.male) {
      // Formula for men
      return (10 * weight) + (6.25 * heightInCm) - (5 * age) + 5;
    } else {
      // Formula for women
      return (10 * weight) + (6.25 * heightInCm) - (5 * age) - 161;
    }
  }

  /// Determines the activity multiplier based on the selected exercise level.
  double _getActivityMultiplier() {
    // Find the index of the selected level in the predefined list
    // Add 1 because the formula uses 1-based indexing
    int levelIndex = exercises.indexWhere((ex) => ex.level == exerciseLevel.level) + 1;

    switch (levelIndex) {
      case 1: // Sedentary
        return 1.2;
      case 2: // Lightly Active
        return 1.375;
      case 3: // Moderately Active
        return 1.55;
      case 4: // Active
        return 1.725;
      case 5: // Super Active
        return 1.9;
      default:
        return 1.2;
    }
  }

  /// Calculates Total Daily Energy Expenditure (TDEE).
  /// TDEE = BMR * Activity Multiplier
  double calculateTDEE() {
    double bmr = calculateBMR();
    double multiplier = _getActivityMultiplier();
    return bmr * multiplier;
  }


  double calculateStandardBMI() {
     if (height <= 0) return 0; // Avoid division by zero
     return weight / (height * height);
  }
}
