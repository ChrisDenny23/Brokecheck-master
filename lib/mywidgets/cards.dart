import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mycard extends StatelessWidget {
  final String Cardtitle;
  final String? ExpiryDate;

  Mycard({
    required this.Cardtitle,
    this.ExpiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              "images/CardBG/Blue.svg", // Background SVG
              // fit: BoxFit.cover, // Cover the entire container
            ),
          ),

          // Foreground Content
          Container(
            width: 370,
            height: 220,
            padding: EdgeInsets.all(26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), // Rounded Corners
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space between logos
                  children: [
                    SvgPicture.asset("images/CardBG/SBI.svg",
                        width: 72), // Top Left Logo
                    SvgPicture.asset(
                        "images/GlobalNetwork/MasterCard.svg"), // Top Right Logo
                  ],
                ),
                // SizedBox(height: 16), // Spacing
                // Spacer (),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text left
                      children: [
                        Text(
                          Cardtitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ), // Bottom Left Text
                        Text(
                          ExpiryDate ?? "Expires: xx/xx",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset("images/GlobalNetwork/MasterCard.svg",
                        width: 40), // Contactless Icon
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
