import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:micro_commons/utils/colors.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavbar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 2,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xFF667085),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: textTheme.bodySmall,
          unselectedLabelStyle: textTheme.bodySmall,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: _HomeIcon(),
            ),
            BottomNavigationBarItem(
              label: "Transactions",
              icon: _TransactionIcon(),
            ),
            BottomNavigationBarItem(
              label: "PI",
              icon: _PiIcon(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeIcon extends StatelessWidget {
  const _HomeIcon();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/home_icon.png',
      width: 29,
      height: 29,
      package: "micro_commons",
    );
  }
}

class _TransactionIcon extends StatelessWidget {
  const _TransactionIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/ion_list.svg',
      package: 'micro_commons',
      height: 30,
      width: 30,
      fit: BoxFit.contain,
    );
  }
}

class _PiIcon extends StatelessWidget {
  const _PiIcon();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/pi_new.png",
      package: "micro_commons",
      width: 32,
      height: 32,
    );
  }
}
