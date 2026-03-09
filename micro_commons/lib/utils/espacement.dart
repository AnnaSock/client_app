
import 'package:flutter/material.dart';

extension SpaceExtension on num {

  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());

  EdgeInsets get p => EdgeInsets.all(toDouble());
  EdgeInsets get ph => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get pv => EdgeInsets.symmetric(vertical: toDouble());

}
