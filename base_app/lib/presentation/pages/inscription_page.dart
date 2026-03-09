// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/custom_sliver_app_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'dart:async';
import 'package:micro_commons/utils/util.dart';
import 'package:micro_commons/utils/void.dart';


class InscriptionPage1 extends StatefulWidget
{
  const InscriptionPage1({super.key});
  @override
  State<InscriptionPage1> createState() => _InscriptionPage1State();
}

class _InscriptionPage1State extends State<InscriptionPage1>
{
  final _formKey1 = GlobalKey<FormState>();
  final baseWidth = 375;

  var prenomController = TextEditingController();
  var nomController = TextEditingController();
  var phoneController = TextEditingController();
  var indicatifController = TextEditingController();
  var paysController = TextEditingController();
  var loginController = TextEditingController();

  FocusNode prenomFocusNode = FocusNode();
  FocusNode nomFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode paysFocusNode = FocusNode();
  FocusNode indicatifFocusNode = FocusNode();
  FocusNode loginFocusNode = FocusNode();
  bool _isButtonDisabled = true;
  String? isoCode2;

  String? whichLanguage = "SN";

  @override
  void initState()
{
    super.initState();
    phoneController.addListener(_updateButtonState);

    const defaultCountryCode = '221';
    indicatifController.text = defaultCountryCode;
    isoCode2 = "SN";

  }

  void _updateButtonState()
{
    Future.delayed(Duration.zero, ()
{
      if (mounted)
{
        setState(()
{
          _isButtonDisabled = phoneController.text.isEmpty;
        });
      }
    });
  }

  @override
  void dispose()
{
    phoneController.removeListener(_updateButtonState);
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
{
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () => unfocus(context),
        child: CustomScrollView(
          slivers: [
          CustomSliverAppBar(
          title: "Inscription",
        ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(16 * fem),
                    color: whiteColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Prénom
                                Text(
                                  "Prénom",
                                  style: safeGoogleFont(
                                    'Lato',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.43 * ffem / fem,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: prenomController,
                                  focusNode: prenomFocusNode,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: customInputDecoration(
                                    prefixIcon: Icons.person_outline_outlined,
                                    hint: "Entrer votre prénom",
                                  ),
                                  validator: (value) =>
                                  value == null || value.isEmpty ? "Champ obligatoire" : null,
                                ),
                                const SizedBox(height: 20),

                                // Nom
                                Text(
                                  "Nom",
                                  style: safeGoogleFont(
                                    'Lato',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.43 * ffem / fem,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: nomController,
                                  focusNode: nomFocusNode,
                                  textCapitalization: TextCapitalization.characters,
                                  decoration: customInputDecoration(
                                    prefixIcon: Icons.person_outline_outlined,
                                    hint: "Entrer votre nom",
                                  ),
                                  validator: (value) =>
                                  value == null || value.isEmpty ? "Champ obligatoire" : null,
                                ),
                                const SizedBox(height: 20),

                                // Numéro de téléphone
                                Text(
                                  "Numéro de téléphone",
                                  style: safeGoogleFont(
                                    'Lato',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.43 * ffem / fem,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                IntlPhoneField(
                                  countries: allowedCountries,
                                  controller: phoneController,
                                  focusNode: phoneFocusNode,
                                  initialCountryCode: 'SN',
                                  decoration: customInputDecoration(
                                    hint: "Votre numéro de téléphone",
                                  ),
                                  dropdownIconPosition:
                                  IconPosition.trailing,
                                  onCountryChanged: (value)
{
                                    setState(()
{
                                      isoCode2 = value.code;
                                      indicatifController.text = value.dialCode;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Bouton Suivant
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: BoutonRouge(
                                    text: "Suivant",
                                    isDisabled: _isButtonDisabled,
                                    onPressed: ()
{
                                      if (_formKey1.currentState!.validate())
{

                                        context.push("/otp");
                                      }
                                    },
                                  ),
                                ),

                                const SizedBox(height: 30),

                                // Lien Se connecter
                                InkWell(
                                  onTap: ()
{
                                 context.go("/home");
                                  },
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Avez-vous déjà un compte ?",
                                          style: safeGoogleFont(
                                            'Lato',
                                            fontSize: 14,
                                            color: hintColor,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Se connecter",
                                          style: safeGoogleFont(
                                            'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


