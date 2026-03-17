import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BalanceCard extends StatelessWidget {
  final double fem;
  final double solde;
  final bool viewSolde;
  final VoidCallback onToggleVisibility;
  final String? qrData;

  const BalanceCard({
    super.key,
    required this.fem,
    required this.solde,
    required this.viewSolde,
    required this.onToggleVisibility,
    required this.qrData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30 * fem,
        right: 8 * fem,
        bottom: 12 * fem,
        top: 12 * fem,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2F296A),
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/figma_hp_banderole.png',
            package: 'micro_commons',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 LEFT PART
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    formatWithSpaces(solde),
                    style: viewSolde
                        ? TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary,
                      fontSize: 20 * fem,
                      fontWeight: FontWeight.bold,
                    )
                        : getHidedStyle(
                      TextStyle(
                        fontSize: 20 * fem,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 5 * fem),
                  Text(
                    "F",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 20 * fem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 40 * fem,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: viewSolde
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      color: Colors.white,
                      onPressed: onToggleVisibility,
                    ),
                  ),
                ],
              ),

              // 🔹 BUTTON
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  ),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(secondaryColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(
                          top: 3, bottom: 3, left: 7, right: 12),
                    ),
                    minimumSize:
                    WidgetStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: Colors.white, size: 18),
                      Text(
                        "Recharger",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔹 QR CODE
          Container(
            margin: EdgeInsets.only(right: 5 * fem),
            padding: EdgeInsets.only(
              left: 8 * fem,
              right: 8 * fem,
              top: 12 * fem,
              bottom: 5 * fem,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE7E9FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: qrData != null
                      ? QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 60,
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                    Theme.of(context).primaryColor,
                    errorCorrectionLevel:
                    QrErrorCorrectLevel.L,
                  )
                      : Image.asset(
                    "assets/images/qr_home.png",
                    package: 'micro_commons',
                    width: 35 * fem,
                    height: 35 * fem,
                    fit: BoxFit.contain,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.camera_alt, size: 12 * fem),
                    SizedBox(width: 2 * fem),
                    Text(
                      "Scanner",
                      style: TextStyle(
                        fontSize: 8 * fem,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
