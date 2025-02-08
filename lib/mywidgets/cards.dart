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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25), // Ensure rounded corners
        child: SizedBox(
          width: 370 - 26,
          height: 220 - 26,
          child: Stack(
            children: [
              // Background SVG
              Positioned.fill(
                child: SvgPicture.asset(
                  "images/CardBG/Green.svg",
                  fit: BoxFit.cover, // Ensures the SVG fills properly
                ),
              ),

              // Foreground Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("images/BankLogos/SBI.svg", width: 72),
                        SvgPicture.asset("images/GlobalNetwork/Visa.svg",
                            width: 35),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Cardtitle,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ExpiryDate ?? "Expires: xx/xx",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          "images/GlobalNetwork/Contactless.svg",
                          width: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
