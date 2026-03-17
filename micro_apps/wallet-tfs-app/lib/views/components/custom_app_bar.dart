import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> homeKey;
  final double fem;
  final String? name;

  const CustomAppBar({
    super.key,
    required this.homeKey,
    required this.fem,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: whiteColor,
      foregroundColor: whiteColor,
      elevation: 0,
      actionsPadding: EdgeInsets.zero,
      leadingWidth: 30,

      // 🔹 MENU
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16),
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () {
          homeKey.currentState!.openDrawer();
        },
      ),

      // 🔹 TITLE
      title: GestureDetector(
        onTap: () => homeKey.currentState!.openDrawer(),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 22 * fem,
              height: 22 * fem,
              decoration: ShapeDecoration(
                color: const Color(0xFFFBBC0FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Center(
                child: Text(
                  getInitials(name ?? ""),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * fem,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 4),

            // Logo
            Image.asset(
              "assets/images/logo_mytouchpoint.png",
              package: 'micro_commons',
              width: 90 * fem,
              height: 40 * fem,
            ),
          ],
        ),
      ),

      // 🔹 ACTIONS
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/icone_notification.svg",
                package: 'micro_commons',
                height: 22 * fem,
                width: 22 * fem,
              ),
            ),
            Positioned(
              right: 14,
              top: 14,
              child: Container(
                width: 8 * fem,
                height: 8 * fem,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/call_customer_service.svg",
              package: 'micro_commons',
              height: 22 * fem,
              width: 22 * fem,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
