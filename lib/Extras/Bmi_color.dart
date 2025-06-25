import 'package:flutter/material.dart';

class BmiColorBar extends StatelessWidget {
  const BmiColorBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _BmiSegment(
            start: '-18.5',
            end: '18.5',
            label: 'Underweight',
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          _BmiSegment(
            start: '18.5',
            end: '24.9',
            label: 'Healthy Weight',
            color: Colors.green,
          ),
          _BmiSegment(
            start: '24.9',
            end: '30+',
            label: 'Obese',
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class _BmiSegment extends StatelessWidget {
  final String start;
  final String end;
  final String label;
  final Color color;
  final BorderRadius? borderRadius;

  const _BmiSegment({
    required this.start,
    required this.end,
    required this.label,
    required this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    double width3 = MediaQuery.of(context).size.width * 0.3;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(start, style: const TextStyle(color: Colors.grey)),
              Text(end, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: width3,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}
