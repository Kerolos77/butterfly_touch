import 'package:butterfly_touch/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../global/default_button.dart';
import '../global/default_text/default_text.dart';
import '../global/default_text_field.dart';

Widget addContainer({
  required double width,
  required double height,
  required String qrcode,
  required TextEditingController descriptionController,
  required void Function() onTapSave,
  required void Function() onTapCancel,
  required void Function(bool) onToggle,
  required bool state,
}) {
  return Container(
      width: width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultText(text: qrcode),
            SizedBox(
              height: height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultText(text: 'Good for the environment?'),
                FlutterSwitch(
                    value: state,
                    borderRadius: 30.0,
                    padding: 8.0,
                    activeColor: ConstColors.green,
                    inactiveColor: Colors.redAccent,
                    onToggle: onToggle),
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            defaultTextField(
                control: descriptionController,
                type: TextInputType.multiline,
                maxLines: null,
                text: 'Description'),
            SizedBox(
              height: height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                defaultButton(
                    text: 'Cancel', onTap: onTapCancel, width: width / 3),
                defaultButton(text: 'Save', onTap: onTapSave, width: width / 3)
              ],
            )
          ],
        ),
      ));
}
