import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors.dart';

Widget logo({required double size}) {
  return SvgPicture.asset(
    "assets/image/logo.svg",
    color: ConstColors.green,
    width: size,
    height: size,
  );
}
