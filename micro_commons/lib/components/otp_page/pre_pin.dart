

import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';

class PrePin extends StatelessWidget {
  final double fem;

  const PrePin({super.key, required this.fem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 30 * fem, 0 * fem, 22.54 * fem),
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 100 * fem,
            height: 100.50 * fem,
            child: Image.asset(
              'assets/images/code_otp.png',
              package: 'micro_commons',
              width: 60 * fem,
              height: 120 * fem,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 327 * fem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Votre code de vérification a été envoyé par",
                  style: TextStyle(
                    color: hintColor,
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
               const SizedBox(height: 5),
                Text(
                  "WhatsApp au +221 78 183 26 23",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    )
    ;
  }
}
