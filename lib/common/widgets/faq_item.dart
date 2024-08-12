import 'package:flutter/material.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String detail;

  const FAQItem({super.key, required this.question, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 20,
                child: const Icon(Icons.help_outline, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(color: borderColor,),
      ],
    );
  }
}
