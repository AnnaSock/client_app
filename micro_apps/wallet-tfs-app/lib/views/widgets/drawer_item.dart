import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:micro_commons/utils/enum.dart';

Widget buildDrawerItem(
    BuildContext context, {
      String? icon,
      Widget? iconWidget,
      required String label,
      Widget? trailing,
      required VoidCallback? onTap,
    })
{
  const baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    leading: Container(
      width: 38 * fem,
      height: 38 * fem,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F6FF),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(8 * fem),
      child: iconWidget ??
          SvgPicture.asset(
            icon!,
            package: 'micro_commons',
            fit: BoxFit.contain,
          ),
    ),
    title: Text(label, style: CustomTextStyle.labelTextStyle),
    trailing: trailing,
    onTap: onTap,
  );
}
