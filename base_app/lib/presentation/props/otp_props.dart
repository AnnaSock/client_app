import 'dart:ui';

import 'package:flutter/material.dart';

class OtpProps {
  final String title;
  final Function(BuildContext) routeGo;

  OtpProps({
    required this.title,
    required this.routeGo,
  });
}
