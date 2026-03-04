import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';


class BoutonRouge extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BoutonRouge({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryBordeaux,
        padding: EdgeInsets.zero,
        minimumSize: const Size.fromHeight(42),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: kPrimaryBordeaux,
            width: 1.0,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 18.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 18.5,
        ),
      ),
    );
  }
}
