
import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';

abstract class Enum<T> {
  final T _value;
  const Enum(this._value);
  T get value => _value;
}

class CustomTextStyle {
  static TextStyle superTitleTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: bodyColor,
  );
  static TextStyle titleTaxes = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: taxeColor,
    decoration: TextDecoration.underline,
    height: 1.5,
  );

  static TextStyle titleTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );

  static TextStyle descriptionTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: bodyColor,
  );

  static TextStyle labelTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: bodyColor,
  );

  static TextStyle recapValueStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );
  static TextStyle recapValueTotalStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  static TextStyle strongLabelTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: bodyColor,
  );

  static TextStyle hintTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: disabledColor,
  );

  static TextStyle disabledTitleTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: disabledColor,
  );

  static TextStyle disabledTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: disabledColor,
  );

  static TextStyle errorTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: errColor,
  );

  static TextStyle titleLabelTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle titleBottomSheetSupportTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: primaryColor,
  );

  static TextStyle titleSupportTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: bodyColor,
  );

  static TextStyle subTitleSupportTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: disabledColor,
  );

  static TextStyle titleChampsTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static TextStyle titleBottomSheetErrorTransctionTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: backgroundBottomSheetErrorIconColor,
  );

  static TextStyle subTitleBottomSheetErrorTransctionTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: backgroundBottomSheetErrorIconColor,
  );

  static TextStyle buttonTextStyle = safeGoogleFont('Lato', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

  static TextStyle buttonOutlinedTextStyle = safeGoogleFont('Lato', fontSize: 16, fontWeight: FontWeight.w500, color: secondaryColor);

  static TextStyle unselectedCategoryTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );
  static TextStyle selectedCategoryTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color:
    primaryColor, /*
      decoration: TextDecoration.underline,
      decorationColor: secondaryColor,
      decorationThickness: 2*/
  );

  static TextStyle productNameTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );
  static TextStyle productPriceTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: secondaryColor,
  );

  static TextStyle textLeftBottomSheetTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: textBottomSheetColor,
  );

  static TextStyle textRightBottomSheetTextStyle = safeGoogleFont(
    'Lato',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primaryColor,
  );

  static snackBar(context, text, [Color? color]) {
    return SnackBar(
      backgroundColor: color ?? primaryColor,
      content: Text(text,
          style: safeGoogleFont(
            'Lato',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }


}

class InfoLine {
  String? label;
  String? image;
  String? value;
  InfoLine(this.label, this.image, this.value);
}
