
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../theme/custom_text_style.dart';

class CustomStatusLayout extends StatelessWidget {
  final String label;
  final Color color;

  const CustomStatusLayout(
      {super.key, required this.label  , required this.color});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15), topRight: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15)),
        child: Container(
          alignment: Alignment.center,
          //padding: EdgeInsets.all(8),
          height: 25,
           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Text(
            label,
            style: CustomTextStyles
                .labelMediumWhiteA700_1,
          ),
        ),
      ),
    );
  }
}