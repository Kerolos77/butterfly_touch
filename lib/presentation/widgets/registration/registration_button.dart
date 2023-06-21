import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget registrationButton({
  required String text,
  required BuildContext context,
  required GestureTapCallback onTap,
}) {
  return
    GestureDetector(
        onTap: onTap,
        child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(26, 188, 0, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: const Color.fromRGBO(255, 255, 255, 1)),
              ),
            )));
}
