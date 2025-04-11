import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const ReusableWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   subtitle,
          //   style: GoogleFonts.quicksand(
          //     fontSize: 16,
          //     color: Colors.blue,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
