import 'package:flutter/material.dart';

class PopPup extends PopupMenuItem<String> {
  PopPup({
    super.key,
    required String value,
    required String image,
    required String text,
  }) : super(
    value: value,
    child: Row(
      children: [
        Image.asset(
          "assets/images/$image",
          package: 'micro_commons',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
