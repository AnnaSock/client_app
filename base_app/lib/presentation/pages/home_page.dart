import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/bouton_blanc.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: LayoutBuilder(builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          final fem = maxW / 375;
          final horizontalPadding = maxW > 600 ? 35.0 : 20.0;
          final topHeight = constraints.maxHeight * 0.46;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [

                      SizedBox(
                        child: Center(
                          child: Image.asset(
                            "assets/images/cercle.png",
                            package: "micro_commons",
                            width: maxW * 0.98,
                            height: topHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const Spacer(),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'MyTouchPoint +',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: kCustomerAppColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Vos transactions, à portée de main, partout et à tout   moment.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 23 * fem,
                                  color: kTextLargeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 46,
                              child: BoutonRouge(
                                  text: "Se Connecter",
                                  onPressed: ()=> {
                                    context.go("/login")
                                  }),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 46,
                              child: BoutonBlanc(
                                  text: "Inscription",
                                  onPressed: ()=> {
                                    context.push("/inscription")
                                  }),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
