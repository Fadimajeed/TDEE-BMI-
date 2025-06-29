import 'package:flutter/material.dart';
import 'dart:math'; 

class BMIPicker extends StatefulWidget {
  final Function(double) onHeightChanged;
  final Function(double) onWeightChanged;
  final double initialHeight;
  final double initialWeight;

  const BMIPicker({
    Key? key,
    required this.onHeightChanged,
    required this.onWeightChanged,
    this.initialHeight = 1.70,
    this.initialWeight = 70.0,
  }) : super(key: key);

  @override
  _BMIPickerState createState() => _BMIPickerState();
}

class _BMIPickerState extends State<BMIPicker> {
  late ScrollController _heightController;
  late ScrollController _weightController;
  late int _selectedHeightIndex;
  late int _selectedWeightIndex;
 // Define item extent as a constant
  final double _itemExtent = 60.0;

  int _heightToIndex(double height) => ((height - 1.20) * 100 + 5000).round();
  int _weightToIndex(double weight) => (weight - 30 + 3000).round();

  double get _height => 1.20 + (_selectedHeightIndex - 5000) * 0.01;
  double get _weight => _selectedWeightIndex - 3000 + 30.0;

  @override
  void initState() {
    super.initState();
    _selectedHeightIndex = _heightToIndex(widget.initialHeight);
    _selectedWeightIndex = _weightToIndex(widget.initialWeight);

    // Calculate initial scroll offsets to center the initial value
    final initialHeightOffset = (_selectedHeightIndex - 5000) * _itemExtent;
    final initialWeightOffset = (_selectedWeightIndex - 3000) * _itemExtent;

    _heightController = ScrollController(initialScrollOffset: initialHeightOffset);
    _weightController = ScrollController(initialScrollOffset: initialWeightOffset);


  }

  @override
  void dispose() {

    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Height: ${_height.toStringAsFixed(2)} m",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _buildInfiniteRuler(
          controller: _heightController,
          minIndex: 5000,
          maxIndex: 9000,
          itemBuilder: (index) {
            double value = 1.20 + (index - 5000) * 0.01;
            // Pass the currently centered index for highlighting
            return _buildMeasurementItem(value.toStringAsFixed(2), _selectedHeightIndex == index);
          },
          onItemSelected: (index) {
            if (_selectedHeightIndex != index) {
              // Update state immediately when snapping finishes
              setState(() => _selectedHeightIndex = index);
              widget.onHeightChanged(_height); 
            }
          },
        ),
        SizedBox(height: 20), 
        Text("Weight: ${_weight.toStringAsFixed(1)} kg",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _buildInfiniteRuler(
          controller: _weightController,
          minIndex: 3000,
          maxIndex: 12000,
          itemBuilder: (index) {
            double value = index - 3000 + 30.0;
            // Pass the currently centered index for highlighting
            return _buildMeasurementItem(value.toStringAsFixed(1), _selectedWeightIndex == index);
          },
          onItemSelected: (index) {
            if (_selectedWeightIndex != index) {
              // Update state immediately when snapping finishes
              setState(() => _selectedWeightIndex = index);
              widget.onWeightChanged(_weight); // Notify parent
            }
          },
        ),
      ],
    );
  }

  Widget _buildInfiniteRuler({
    required ScrollController controller,
    required int minIndex,
    required int maxIndex,
    required Widget Function(int index) itemBuilder,
    required Function(int index) onItemSelected,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate padding to center items
    final horizontalPadding = max(0.0, (screenWidth / 2) - (_itemExtent / 2));
    final itemCount = maxIndex - minIndex + 1;

    return SizedBox(
      height: 70, 
      child: Stack(
        alignment: Alignment.center,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                // Calculate the index closest to the center based on current offset
                final centerItemIndexFloat = controller.offset / _itemExtent;
                final closestItemIndex = centerItemIndexFloat.round();
                final clampedIndex = closestItemIndex.clamp(0, itemCount - 1);
                final targetOffset = clampedIndex * _itemExtent;

                // Animate snapping to the calculated target offset
                if ((controller.offset - targetOffset).abs() > 1.0) {
                  controller.animateTo(
                    targetOffset,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ).then((_) {
                     // Ensure state update happens after animation completes
                     if (mounted) {
                        final finalIndex = (controller.offset / _itemExtent).round() + minIndex;
                        onItemSelected(finalIndex.clamp(minIndex, maxIndex));
                     }
                  });
                } else {
                   // If already close, just update state
                   if (mounted) {
                      final finalIndex = (controller.offset / _itemExtent).round() + minIndex;
                      onItemSelected(finalIndex.clamp(minIndex, maxIndex));
                   }
                }
              }
              return true;
            },
            child: ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemExtent: _itemExtent,
              itemCount: itemCount,
              // Add padding to allow first/last items to reach center
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              itemBuilder: (context, index) => itemBuilder(index + minIndex),
            ),
          ),
          // Static Center Indicator
          Positioned(
            top: 0,
            bottom: 20, 
            child: Container(
              width: 3, 
              color: Colors.red, 
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildMeasurementItem(String label, bool isSelected) {
    // isSelected passed from itemBuilder to highlight the correct item
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isSelected ? 3 : 1.5, // Thicker line for selected
            height: isSelected ? 25 : 15,
            color: isSelected ? Colors.green : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isSelected ? 14 : 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
