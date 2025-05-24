import 'package:flutter/material.dart';

class EcoPointsCount extends StatelessWidget {
  const EcoPointsCount({
    super.key,
    required this.ecoPoints,
    required this.numberColor,
    required this.iconSize,
    required this.textSize,
  });

  final int ecoPoints;
  final Color numberColor;
  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              Icons.trending_up,
              color: Colors.amber,
              size: iconSize,
              weight: 18,
            ),
          ),
          TextSpan(
            text: ' Eco Points: ',
            style: TextStyle(
              color: Colors.amber,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '$ecoPoints',
            style: TextStyle(
              color: numberColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
