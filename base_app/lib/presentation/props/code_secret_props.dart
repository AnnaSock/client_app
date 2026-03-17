import 'dart:ui';

import 'package:flutter/material.dart';

class CodeSecretProps {
   final String titre;
   final String sousTitre;
   final String image;
   final String paragraphe;
   final String input1;
   final String input2;
   final Function(BuildContext) routeGo;
  const CodeSecretProps({
    required this.titre,
    required this.sousTitre,
    required this.image,
    required this.paragraphe,
    required this.input1,
    required this.input2,
    required this.routeGo
  });
}