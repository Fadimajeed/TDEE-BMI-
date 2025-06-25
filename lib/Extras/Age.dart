import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgePicker extends StatefulWidget {
  final int initialAge; // Initial age from parent
  final ValueChanged<int> onChanged; // Callback to notify parent

  const AgePicker({
    Key? key,
    required this.initialAge,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<AgePicker> createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {

  void _showAgePicker() {
    int tempSelectedAge = widget.initialAge;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // Increased height slightly to prevent overflow
          height: 240, 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              SizedBox(
                height: 160, // Height of the picker itself
                child: CupertinoPicker(
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(initialItem: widget.initialAge),
                  onSelectedItemChanged: (index) {
                    tempSelectedAge = index;
                  },
                  children: List.generate(
                    101, // Age range 0-100
                    (index) => Center(
                      child: Text(
                        '$index',
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
              
              CupertinoButton(
                child: Text('Done', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  widget.onChanged(tempSelectedAge);
                  Navigator.of(context).pop();
                },
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double boxWidth = MediaQuery.of(context).size.width * 0.6;

    return Center(
      child: GestureDetector(
        onTap: _showAgePicker,
        child: Container(
          width: boxWidth,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.initialAge == 0 ? 'Select age' : 'Age: ${widget.initialAge}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
