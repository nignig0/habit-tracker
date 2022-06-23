import 'package:flutter/material.dart';


class ColoredBlock extends StatelessWidget {
  
  Color color;
  double height; 
  double width;
  Widget child;
  ColoredBlock({required this.color, required this.height,  required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, 
      width: width,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), 
        color: color,

      ), 

      child: child,
    );
  }
}