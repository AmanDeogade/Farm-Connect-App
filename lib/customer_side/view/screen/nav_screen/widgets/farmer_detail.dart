import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:farmconnect/customer_side/view/screen/details/farmer_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDetails extends StatelessWidget {
  final Farmer farmer;

  const FarmerDetails({super.key, required this.farmer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return FarmerDetailScreen(farmer: farmer);
            },
          ),
        );
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade200,
              ),
              child: Stack(
                children: [
                  Image.network(
                    farmer.profileImage,
                    height: 170,
                    width: 190,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              farmer.fullName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              farmer.city,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7F7F7F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
