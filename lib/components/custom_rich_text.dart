import 'package:flutter/cupertino.dart';

import '../app_colors.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String text;

  const CustomRichText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: AppColors.accentColor,
          fontSize: 15,
        ),
        children: <TextSpan>[
          TextSpan(text: '$title : '),
          TextSpan(
            text: text,
            style: const TextStyle(
              color: AppColors.accentColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}