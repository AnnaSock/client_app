import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/enum.dart';

class CguTitleWidget extends StatelessWidget {
  final String title;

  const CguTitleWidget(
      {super.key, this.title = 'Conditions Générales d’Utilisation'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CguBodyWidget extends StatelessWidget {
  final String text;

  const CguBodyWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: CustomTextStyle.labelTextStyle,
        textAlign: TextAlign.start,
      ),
    );
  }
}