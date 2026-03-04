// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';

class CustomAppBar extends StatefulWidget {
  final String? title;
  final int? height;
  final Widget? icon;
  bool? isLogging;
  bool? profile;
  bool? fromTab;
  final VoidCallback? onBackPressed; // <-- nouveau
  bool? fromPaiement;
  Map<String, dynamic>? user = {"firstname": "", "lastname": ""};

  CustomAppBar({super.key, this.title, this.onBackPressed, this.user, this.height = -50, this.isLogging = false, this.profile = false, this.fromTab, this.fromPaiement, this.icon});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final baseWidth = 375;
  //final genericAnalyticsService = GenericAnalyticsService(AnalyticService());
  //final authAnalyticsService = AuthAnalyticsService(AnalyticService());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        circular(context),
        if (widget.isLogging!) homeAppBar(context) else genericAppBar(context),
      ],
    );
  }

  Widget circular(context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Positioned(
      left: MediaQuery.of(context).size.width - 120 * fem,
      top: widget.height! * fem,
      child: Align(
        child: SizedBox(
          width: 200 * fem,
          height: 200 * fem,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  bgCircleColor.withOpacity(0.6),
                  whiteColor.withOpacity(0.01),
                ],
              ),
              borderRadius: BorderRadius.circular(150 * fem),
            ),
            height: 100 * fem,
            child: Padding(
              padding: EdgeInsets.all(35 * fem),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(150 * fem),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget genericAppBar(context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return widget.profile!
        ? Container(
        padding: EdgeInsets.symmetric(horizontal: 25 * fem),
        margin: EdgeInsets.only(top: 20 * fem),
        width: 250 * fem,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title!,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ))
        : Container(
      width: 350 * fem,
      padding: EdgeInsets.symmetric(horizontal: 10 * fem),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.fromTab == null || widget.fromTab == false) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                widget.icon == null
                    ? IconButton(
                  onPressed: () {

                    // Si un callback personnalisé est fourni, on le déclenche en priorité.
                    if (widget.onBackPressed != null) {
                      widget.onBackPressed!.call();
                      return;
                    }

                    // Sinon, fallback sur le comportement existant (pop / nav to Welcome)
                    /*Navigator.canPop(context)
                        ? widget.fromPaiement != null && widget.fromPaiement == true
                        ? Navigator.push(context, MaterialPageRoute(builder: (builder) => WelcomeWalletTFS(selectedIndex: 0, selectedTab: 0)))
                        : Navigator.pop(context)
                        : null;*/

                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                  ),
                )
                    : widget.icon as Widget,
                Expanded(
                  child: Text(
                    widget.title ?? "",
                    style: const TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget homeAppBar(context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25 * fem),
      margin: EdgeInsets.only(top: 20 * fem),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '''${widget.title!},\n''',
                    style: safeGoogleFont(
                      'Lato',
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '''${widget.user!["firstname"]!} ${widget.user!["lastname"]!}''',
                    style: safeGoogleFont(
                      'Lato',
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 24 * fem,
                    height: 24 * fem,
                    child: TextButton(
                      onPressed: () {

                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(
                        Icons.contact_support,
                        size: 25,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
