import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String principalText;
  final String? secondaryText;
  final bool? titleMode;

  const DescriptionText(
      {super.key,
      required this.principalText,
      this.secondaryText,
      this.titleMode});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                '$principalText${(titleMode != null && titleMode == true) ? '''\n\n''' : ': '}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (titleMode != null && titleMode == true) ? 20 : 15,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: secondaryText ?? 'Not available',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
