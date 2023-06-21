import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget otherRegistration({
  required VoidCallback onPressGoogle,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: const Color.fromRGBO(151, 151, 151, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8),
            child: Text(
              "or continue with",
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: const Color.fromRGBO(151, 151, 151, 1),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: const Color.fromRGBO(151, 151, 151, 1),
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/image/Google.svg",
              width: 33,
              height: 32,
            ),
            onPressed: onPressGoogle,
          ),
        ],
      )
    ],
  );
}
