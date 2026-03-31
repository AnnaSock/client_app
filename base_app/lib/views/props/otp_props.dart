import 'dart:ui';

import 'package:flutter/material.dart';

class OtpProps {
  final String? codeOtp;
  final String title;
  final Function(BuildContext) routeGo;

  OtpProps({
    this.codeOtp,
    required this.title,
    required this.routeGo,
  });
}
