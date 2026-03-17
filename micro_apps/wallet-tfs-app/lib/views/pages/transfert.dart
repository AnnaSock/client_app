import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/enum.dart';
import 'package:micro_commons/utils/util.dart';

class TransfertTfsSegment extends StatefulWidget {

  const TransfertTfsSegment({super.key});

  @override
  State<TransfertTfsSegment> createState() => _TransfertTfsSegmentState();
}

class _TransfertTfsSegmentState extends State<TransfertTfsSegment> {
  final baseWidth = 375;
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [

          /// 🔴 FROM
          Align(
            alignment: Alignment.centerLeft,
            child: Text("From", style: CustomTextStyle.titleLabelTextStyle),
          ),
          SizedBox(height: 5 * fem),

          Row(
            children: [
              Expanded(
                flex: 12,
                child: DropdownButtonFormField(
                  items: const [],
                  onChanged: null,
                  decoration: customInputDecoration(
                    radius: "left",
                    bgColor: const Color(0xFFF5F6FF),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: DropdownButtonFormField(
                  items: const [],
                  onChanged: null,
                  decoration: customInputDecoration(radius: "right"),
                ),
              ),
            ],
          ),

          /// 🔴 PHONE FROM
          SizedBox(height: 10 * fem),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: TextFormField(
                  enabled: false,
                  decoration: customInputDecoration(
                    radius: "left",
                    bgColor: const Color(0xFFF5F6FF),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: TextFormField(
                  decoration: customInputDecoration(
                    hint: "Numéro",
                    radius: "right",
                  ),
                ),
              ),
            ],
          ),

          /// 🔴 OTP (design only)
          SizedBox(height: 15 * fem),
          TextFormField(
            decoration: customInputDecoration(
              labelText: "Code OTP",
            ),
          ),

          /// 🔴 TO
          SizedBox(height: 15 * fem),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("To", style: CustomTextStyle.titleLabelTextStyle),
          ),
          SizedBox(height: 5 * fem),

          Row(
            children: [
              Expanded(
                flex: 12,
                child: DropdownButtonFormField(
                  items: const [],
                  onChanged: null,
                  decoration: customInputDecoration(
                    radius: "left",
                    bgColor: const Color(0xFFF5F6FF),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: DropdownButtonFormField(
                  items: const [],
                  onChanged: null,
                  decoration: customInputDecoration(radius: "right"),
                ),
              ),
            ],
          ),

          /// 🔴 PHONE TO
          SizedBox(height: 10 * fem),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: TextFormField(
                  enabled: false,
                  decoration: customInputDecoration(
                    radius: "left",
                    bgColor: const Color(0xFFF5F6FF),
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: TextFormField(
                  decoration: customInputDecoration(
                    hint: "Numéro",
                    radius: "right",
                  ),
                ),
              ),
            ],
          ),

          /// 🔴 AMOUNT
          SizedBox(height: 15 * fem),
          TextFormField(
            decoration: customInputDecoration(
              hint: "Montant",
              suffixIcon: Container(
                width: 38,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F6FF),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Text("FCFA"),
              ),
            ),
          ),

          /// 🔴 BUTTON
          SizedBox(height: 20 * fem),
          SizedBox(
            height: 40 * fem,
            width: MediaQuery.of(context).size.width * 0.94,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: null,
              child: Text(
                "Envoyer",
                style: safeGoogleFont(
                  'Lato',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


