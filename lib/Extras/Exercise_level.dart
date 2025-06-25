import 'package:flutter/material.dart';

class EXle {
  final String level;
  final String description;
  const EXle({required this.level, required this.description});

  // Added equality operator for DropdownButton value comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EXle &&
          runtimeType == other.runtimeType &&
          level == other.level &&
          description == other.description;

  @override
  int get hashCode => level.hashCode ^ description.hashCode;
}

const List<EXle> exercises = [
  EXle(
    level: 'Sedentary',
    description: 'Little to no exercise, mostly sitting or resting.',
  ),
  EXle(
    level: 'Lightly Active',
    description: 'Light daily activity such as walking or casual chores.',
  ),
  EXle(
    level: 'Moderately Active',
    description: 'Regular activity 3–5 days a week like biking or gym workouts.',
  ),
  EXle(
    level: 'Active',
    description: 'Hard exercise most days, including sports or intense training.',
  ),
  EXle(
    level: 'Super Active',
    description: 'Athlete-level training or physically demanding job daily.',
  ),
];


// Now accepts selectedLevel and onChanged from the parent
class ExerciseLevelCard extends StatelessWidget {
  final EXle selectedLevel;
  final ValueChanged<EXle?> onChanged;

  const ExerciseLevelCard({ 
    Key? key,
    required this.selectedLevel,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Adjusted padding
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EXle>(
          isExpanded: true,
          value: selectedLevel, // Use value from parent
          icon: Icon(Icons.arrow_drop_down, color: Colors.green),
          onChanged: onChanged, // Notify parent of changes
          items: exercises.map((ex) {
            return DropdownMenuItem<EXle>(
              value: ex,
              child: Text(ex.level), // Display only level in dropdown list
            );
          }).toList(),
          // Use selectedItemBuilder to show description only for the selected item
          selectedItemBuilder: (context) {
            return exercises.map((ex) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${ex.level}: ${ex.description}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2,
                  softWrap: true,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
