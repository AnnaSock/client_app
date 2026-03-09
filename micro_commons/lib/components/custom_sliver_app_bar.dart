import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart'; // Assure-toi d'importer tes couleurs
import 'custom_app_bar.dart'; // Ton CustomAppBar existant

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final baseWidth = 375;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SliverAppBar(
      expandedHeight: 103.0 * fem,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(color: primaryColor),
        child: CustomAppBar(
          title: title,
          icon: IconButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
