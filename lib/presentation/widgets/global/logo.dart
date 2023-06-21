import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget logo({required double size}) {
  return SvgPicture.asset(
          "assets/image/logo.svg",
          color: const Color.fromRGBO(26, 188, 0, 0.8274509803921568),
          width: size,
          height: size,
        );
}

