import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:wallet_tfs_app/views/widgets/custom_user_header.dart';
import 'package:wallet_tfs_app/views/widgets/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  final baseWidth = 375;

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: whiteColor,
      surfaceTintColor: whiteColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomUserHeader(
              name: "Anna Sock",
              phoneNumber: "+221 78 183 26 23",
              onClose: ()
              {
                Navigator.pop(context);
              },
              fem: fem,
            ),
            const Divider(),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 4 * fem),
                children: [

                  buildDrawerItem(
                    context,
                    icon: "assets/images/deplafonner.svg",
                    label: "Deplafonner",
                    onTap: ()
                    {
                    },
                  ),

                  buildDrawerItem(
                    context,
                    icon: "assets/images/lock.svg",
                    label: "Changer code secret",
                    onTap: ()
                    {

                    },
                  ),

                  buildDrawerItem(
                    context,
                    icon: "assets/images/customer.svg",
                    label: "Service Client",
                    onTap: ()
                    {
                    },
                  ),

                  buildDrawerItem(
                    context,
                    icon: "assets/images/share_icon_fill.svg",
                    label: "Recommander a un ami",
                    onTap: ()
                    {

                    },
                  ),

                  buildDrawerItem(
                    context,
                    icon: "assets/images/logout.svg",
                    label: "Deconnexion",
                    onTap: ()
                    {

                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
