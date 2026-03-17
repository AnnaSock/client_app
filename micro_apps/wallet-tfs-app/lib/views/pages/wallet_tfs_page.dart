import 'package:flutter/material.dart';
import 'package:micro_commons/components/bottom_nav_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:wallet_tfs_app/views/pages/home_tfs_page.dart';

class WalletTfsPage extends StatefulWidget {
  int? selectedIndex;
  int? selectedTab;
  WalletTfsPage({super.key, this.selectedIndex, this.selectedTab});

  @override
  State<WalletTfsPage> createState() => _WalletTfsPageState();
}

class _WalletTfsPageState extends State<WalletTfsPage> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              widget.selectedIndex = index;
              widget.selectedTab = 0;
            });
          },
        children: <Widget> [
          HomeTFSPage()
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
