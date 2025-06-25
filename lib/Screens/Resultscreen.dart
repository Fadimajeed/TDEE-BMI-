import 'package:flutter/material.dart';
import 'package:sasy/Extras/Bmi_color.dart';


// --- Dynamic Advice Generation Function ---
// (Included here for simplicity, consider moving to a helper file)
String generateDynamicAdvice(double bmiValue, double tdeeValue) {
  String bmiCategory;
  String weightGoalAdvice;
  String calorieAdvice;
  String specificTips;

  // 1. Determine BMI Category and associated advice
  if (bmiValue < 18.5) {
    bmiCategory = "Underweight";
    weightGoalAdvice =
        "The primary goal might be gradual and healthy weight gain. Focus on nutrient-dense foods.";
    calorieAdvice =
        "To gain weight healthily, aim for a consistent calorie surplus. Consuming around ${(tdeeValue + 300).round()}-${(tdeeValue + 500).round()} kcal daily could be a starting point. Monitor progress and adjust.";
    specificTips = """
*   Focus on nutrient-dense foods (avocados, nuts, seeds, whole grains, lean proteins).
*   Consider eating smaller, more frequent meals and snacks.
*   Incorporate strength training to build muscle mass.
*   Consult Professionals: Work with a doctor or registered dietitian.
""";
  } else if (bmiValue < 25) {
    bmiCategory = "Healthy Weight";
    weightGoalAdvice =
        "The primary goal is weight maintenance. Focus on sustaining healthy habits.";
    calorieAdvice =
        "Aim to consume around ${(tdeeValue * 0.98).round()}-${(tdeeValue * 1.02).round()} kcal daily (approx. your TDEE of ${tdeeValue.round()} kcal) to maintain your current weight.";
    specificTips = """
*   Continue focusing on a balanced diet with whole foods.
*   Be mindful of portion sizes.
*   Maintain your current exercise routine (cardio and strength).
*   Prioritize hydration, adequate sleep, and stress management.
""";
  } else if (bmiValue < 30) {
    bmiCategory = "Overweight";
    weightGoalAdvice =
        "The primary goal might be gradual and sustainable weight loss to reduce health risks.";
    calorieAdvice =
        "To lose weight healthily, aim for a moderate calorie deficit. Consuming around ${(tdeeValue - 500).round()}-${(tdeeValue - 300).round()} kcal daily could be a starting point (deficit of 300-500 kcal from TDEE of ${tdeeValue.round()} kcal).";
    specificTips = """
*   Focus on a sustainable calorie deficit through diet and exercise.
*   Emphasize whole foods; increase vegetables, fruits, lean protein. Limit processed foods/drinks.
*   Combine cardio (150+ min/week) with strength training (2-3 times/week).
*   Practice mindful eating and consider meal planning/tracking.
*   Consult Professionals: Consider consulting a doctor or dietitian.
""";
  } else {
    // bmiValue >= 30
    bmiCategory = "Obesity";
    weightGoalAdvice =
        "The primary goal is typically significant and sustainable weight loss to improve health.";
    calorieAdvice =
        "A structured approach is recommended. Consuming around ${(tdeeValue - 750).round()}-${(tdeeValue - 500).round()} kcal daily could be a starting point (deficit of 500-750 kcal from TDEE of ${tdeeValue.round()} kcal), but **professional guidance is crucial**.";
    specificTips = """
*   **Professional Guidance Highly Recommended:** Work closely with a healthcare provider (doctor, dietitian).
*   Focus on sustainable changes in diet, increased physical activity, and behavioral strategies.
*   Prioritize nutrient-dense, low-calorie foods. Significantly reduce processed items.
*   Gradually increase physical activity as advised by your provider.
*   Consider support systems or counseling.
""";
  }

  // Simplified advice format for display in the app
  String advice = """
**BMI Status:** $bmiCategory (${bmiValue.toStringAsFixed(1)})

**Weight Goal:** $weightGoalAdvice

**Calorie Target:** $calorieAdvice

**Key Tips:**
$specificTips

**Disclaimer:** This is general advice. Consult a healthcare professional for personalized guidance.
""";

  return advice;
}
// --- End of Advice Generation Function ---

/// Result screen that shows BMI (with color coding), TDEE, and dynamic advice.
class FullResult extends StatelessWidget {
  final double bmiValue;
  final double tdeeValue;

  const FullResult({Key? key, required this.bmiValue, required this.tdeeValue})
    : super(key: key);

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final bmiColor = _getBmiColor(bmiValue);
    // Generate the advice text dynamically
    final String adviceText = generateDynamicAdvice(bmiValue, tdeeValue);

    return Scaffold(
      // Use SingleChildScrollView to prevent overflow if content is long
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center, // No longer needed with scroll view
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- BMI Section ---
                const Text(
                  "Your BMI is :",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  bmiValue.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: bmiColor,
                  ),
                ),
                const SizedBox(height: 20), // Spacing after BMI
                BmiColorBar(),
                const SizedBox(height: 24),
                // --- TDEE Section ---
                const Text(
                  "Estimated Daily Calories (TDEE):",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      tdeeValue.round().toString() + " kcal",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Spacing after TDEE
                // --- Dynamic Advice Section ---
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100, // Light background for advice
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    adviceText, // Display the generated advice
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ), // Added line height
                  ),
                ),
                const SizedBox(height: 30), // Spacing before button
                // --- Go back button ---
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
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "RECALCULATE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
