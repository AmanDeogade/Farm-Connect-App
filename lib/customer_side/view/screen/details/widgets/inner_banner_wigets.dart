import 'package:flutter/material.dart';

class InnerBannerWigets extends StatelessWidget {
  final String image;

  const InnerBannerWigets({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(image, fit: BoxFit.cover)),
      ),
    );
  }
}
