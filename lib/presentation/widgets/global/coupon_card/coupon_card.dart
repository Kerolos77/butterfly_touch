import 'package:butterfly_touch/presentation/widgets/global/default_text/default_text.dart';
import 'package:butterfly_touch/presentation/widgets/global/logo.dart';
import 'package:flutter/material.dart';
import 'package:ticket_material/ticket_material.dart';

Widget ticketLeft({
  required String startDate,
  required String endDate,
  required String daysLeft,
  required String couponId,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
              ),
              child: defaultText(
                text: '30%',
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: logo(
                size: 45.0,
              ),
            ),
          ),
        ],
      ),
      defaultText(
        size: 20,
        color: Colors.white,
        text: couponId,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: defaultText(
            text: 'You Achieved a New Score',
            size: 8.0,
            color: Colors.white,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 8.0,
              ),
              child: defaultText(
                text: 'Started date $startDate',
                size: 8.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
              ),
              child: defaultText(
                text: 'Expired Date $endDate',
                size: 9.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 8.0,
              ),
              child: defaultText(
                text: 'days left : $daysLeft',
                size: 8.0,
                color: Color.fromRGBO(245, 226, 10, 1.0),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget ticketRight() {
  return const Icon(
    Icons.discount,
    size: 20,
    color: Colors.white,
  );
}

Widget coupon({
  required String startDate,
  required String endDate,
  required String couponId,
}) {
  var start = DateTime.parse(startDate);
  var end = DateTime.parse(endDate);
  int daysLeft = end.difference(start).inDays;

  return TicketMaterial(
    height: 140,
    colorBackground: Colors.black87,
    leftChild: ticketLeft(
      startDate: startDate,
      endDate: endDate,
      couponId: couponId,
      daysLeft: daysLeft.toString(),
    ),
    rightChild: ticketRight(),
  );
}
