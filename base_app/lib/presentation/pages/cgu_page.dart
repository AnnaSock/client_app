import 'package:flutter/material.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/custom_sliver_app_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/enum.dart';
import 'package:micro_commons/utils/void.dart';
import 'package:micro_commons/components/cgu_page/texte.dart';

class CguPage extends StatefulWidget {
  const CguPage({super.key});

  @override
  State<CguPage> createState() => _CguPageState();
}

class _CguPageState extends State<CguPage> {
  final formKey3 = GlobalKey<FormState>();
  final baseWidth = 375;
  bool isCGUChecked = false;
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          body: GestureDetector(
            onTap: () => unfocus(context),
            child: CustomScrollView(
              slivers: [
                CustomSliverAppBar(title: "Conditions générales d'utilisation"),
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 30 * fem),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Texte(),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isCGUChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              isCGUChecked = value!;
                                            });
                                          },
                                          activeColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "J'accepte les termes et conditions",
                                              style: CustomTextStyle
                                                  .labelTextStyle,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: BoutonRouge(text: "Accepter", onPressed: ()=>{}),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]
                    ))
              ],
            ),
          )
      ),
    );
  }
}
