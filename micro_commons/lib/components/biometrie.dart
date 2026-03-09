import 'package:flutter/material.dart';
import 'package:micro_commons/components/bouton_blanc.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/utils/espacement.dart';
import 'package:micro_commons/utils/util.dart';

class BiometricActivationModal extends StatelessWidget {
  final VoidCallback onActivate;
  final VoidCallback onLater;

  const BiometricActivationModal({
    super.key,
    required this.onActivate,
    required this.onLater,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15,
        right: 15,
      ),
      child: Container(
        margin: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// icon
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/bio_icon.png',
                package: 'micro_commons',
                height: 56,
                width: 56,
              ),
            ),

            /// titre
            Text(
              "Activer la biométrie",
              style: safeGoogleFont(
                'Lato',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// description
            Text(
              "Activez la biométrie pour vous connecter plus rapidement et en toute sécurité.",
              style: safeGoogleFont(
                'Lato',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF667085),
              ),
            ),

            const Spacer(),

            Column(
              children: [

                /// bouton activer
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: BoutonRouge(text: "Activer", onPressed: onActivate),
                ),

                8.h,

                /// bouton plus tard
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: BoutonBlanc(text: "Plus tard", onPressed: onLater),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showBiometricActivationModal(
    BuildContext context, {
      required VoidCallback onActivate,
      required VoidCallback onLater,
    }) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
    ),
    builder: (ctx) {
      return BiometricActivationModal(
        onActivate: onActivate,
        onLater: onLater,
      );
    },
  );
}
