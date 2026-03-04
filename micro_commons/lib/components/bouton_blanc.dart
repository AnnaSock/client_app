import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';




class BoutonBlanc extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BoutonBlanc({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: kSecondaryBlueColor,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
        minimumSize: const Size.fromHeight(42),
        backgroundColor: Colors.transparent,
        // Ce style est appliqué au Text enfant
        textStyle: const TextStyle(
          fontSize: 18.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kSecondaryBlueColor,
          fontSize: 18.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
