import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/enum.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pinput/pinput.dart';

TextStyle safeGoogleFont(
    String fontFamily, {
      TextStyle? textStyle,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      Locale? locale,
      Paint? foreground,
      Paint? background,
      List<Shadow>? shadows,
      List<FontFeature>? fontFeatures,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
    }) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}


BoxDecoration customBoxDecoration({IconData? prefixIcon, IconButton? suffixIcon, String? hint, Color? bgColor, Color? borderColor, EdgeInsets? padding, BorderRadius? radius, String? type}) {
  return BoxDecoration(
    color: lightPrimaryColor,
    borderRadius: radius ?? const BorderRadius.horizontal(right: Radius.zero, left: Radius.circular(10)),
    border: Border.all(color: Colors.grey.withOpacity(0.2)),
  );
}

InputDecoration customInputDecoration(
    {TextEditingController? phoneController,
      IconData? prefixIcon,
      Widget? suffixIcon,
      String? suffixText,
      double? suffixfontSize,
      String? hint,
      Color? colorHint,
      String? labelText,
      Color? bgColor,
      Color? borderColor,
      EdgeInsets? padding,
      Object? radius,
      String? type,
      String? errorText}) {
  bool inputCorrect = true;
  if (phoneController != null) inputCorrect = formatPhoneNumber(phoneController.text) == null ? false : true;
  if (radius == "right") {
    radius = const BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(10));
  } else if (radius == "left") {
    radius = const BorderRadius.horizontal(right: Radius.zero, left: Radius.circular(10));
  } else {
    radius = BorderRadius.circular(10);
  }
  return InputDecoration(
    labelText: labelText,
    hintText: hint ?? "",
    labelStyle: CustomTextStyle.labelTextStyle,
    hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: colorHint ?? hintColor, fontFamily: "Lato"),
    filled: true,
    fillColor: bgColor ?? lightPrimaryColor,
    contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
    counter: const Offstage(),
    focusedBorder: inputCorrect
        ? OutlineInputBorder(borderRadius: radius as BorderRadius, borderSide: BorderSide(color: borderColor ?? primaryColor))
        : OutlineInputBorder(
      borderRadius: radius as BorderRadius,
      borderSide: const BorderSide(color: errColor),
    ),
    disabledBorder: inputCorrect
        ? OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    )
        : OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: errColor.withOpacity(0.2)),
    ),
    enabledBorder: inputCorrect
        ? OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    )
        : OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: errColor.withOpacity(0.2)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: errColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: errColor.withOpacity(0.2)),
    ),
    prefixIcon: prefixIcon != null
        ? Icon(
      prefixIcon,
      color: const Color(0xff667085),
    )
        : null,
    suffixIcon: suffixText != null
        ? Container(
      padding: const EdgeInsets.only(right: 8),
      width: 10,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          suffixText,
          style: TextStyle(fontSize: suffixfontSize ?? 14, fontWeight: FontWeight.w500, color: primaryColor),
        ),
      ),
    )
        : suffixIcon,
    errorText: errorText,
  );
}


String? formatPhoneNumber(String phoneNumber) {
  // Remove spaces and special characters from the phone number
  String phoneNumberWithoutSpaces = phoneNumber.replaceAll(RegExp(r'\D'), '');
  // Check if the phone number contains letters
  RegExp regex = RegExp(r'[a-zA-Z]');
  bool containsLetters = regex.hasMatch(phoneNumberWithoutSpaces);
  if (containsLetters || phoneNumberWithoutSpaces.length > 12) {
    return null;
  } else {
    // Remove leading '221' if present
    String digitsOnly = phoneNumberWithoutSpaces.startsWith('221') ? phoneNumberWithoutSpaces.substring(3) : phoneNumberWithoutSpaces;
    return digitsOnly;
  }
}


final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: const TextStyle(fontSize: 12, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: moonColor),
      color: whiteColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0c101828),
          offset: Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    ));

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);
final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(color: bgCircleColor),
);

final allowedCountries = countries
    .where((c) => ['SN', 'CI'].contains(c.code))
    .toList();


String? validatePassword(String? password) {
  RegExp regex = RegExp(r'^\d{4}$');
  if (!regex.hasMatch(password!)) {
    return 'Your password does not meet the requirements';
  }
  return null;
}
