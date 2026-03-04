// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/custom_app_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'dart:async';

import 'package:micro_commons/utils/util.dart';


final allowedCountries = countries
    .where((c) => ['SN', 'CI'].contains(c.code))
    .toList();




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

  bool _isLoading = false;
  String? whichLanguage, whichCountry, phoneLocation = "SN";
  List<String> countryWithSMS = ["SN", "CI"];
  String? legalEntityCode;
  List<String> countryFavorites = [
    "SN",
    "CI",
    "CM",
    "GA",
    "BF",
    "ML",
    "GN",
    "KE"
  ];
  String? _phoneError;
  final bool _submitted = false;
  bool _isSuccess = false;
  bool showLinear = false;




  @override
  void initState()
{
    super.initState();
    phoneController.addListener(_updateButtonState);

    const defaultCountryCode = '221';
    legalEntityCode = legalEntityMap["+$defaultCountryCode"];
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

  void validatePhoneNumber()
{
    setState(()
{
      if (phoneController.text.isEmpty)
{
        _phoneError = "error";
      } else
{
        _phoneError = null;
      }
    });
  }

  final Map<String, String> legalEntityMap =
{
    '+221': 'INTOUCH_SA',
    '+225': 'INTOUCH_CI',
    '+223': 'INTOUCH_ML',
    '+237': 'INTOUCH_CM',
    '+224': 'INTOUCH_GN',
    '+226': 'INTOUCH_BF',
    '+254': 'INTOUCH_KE',
    '+220': 'INTOUCH_GM',
    '+241': 'INTOUCH_GA',
    '+234': 'INTOUCH_NG',
    '+256': 'INTOUCH_UG',
    '+258': 'INTOUCH_MZ',
    '+255': 'INTOUCH_TZ',
    '+229': 'INTOUCH_BN',
    '+233': 'INTOUCH_GH',
    '+267': 'INTOUCH_BW',
    '+265': 'INTOUCH_MW',
    '+260': 'INTOUCH_ZM',
    '+263': 'INTOUCH_ZW',
    '+251': 'INTOUCH_ET',
    '+250': 'INTOUCH_RW',
    '+242': 'INTOUCH_CG',
    '+243': 'INTOUCH_CD',
    '+228': 'INTOUCH_TG',
    '+235': 'INTOUCH_TD',
    '+245': 'INTOUCH_GW',
    '+222': 'INTOUCH_MR',
    '+227': 'INTOUCH_NE',
    '+236': 'INTOUCH_RCA',
    '+27': 'INTOUCH_ZA',
  
};



  @override
  Widget build(BuildContext context)
{
    double fem = MediaQuery.of(context).size.width / baseWidth;
    whichLanguage = Localizations.localeOf(context).languageCode;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: ()
{
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus)
{
            currentFocus.unfocus();
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 103.0 * fem, // Initial height of the AppBar
              pinned: true, // Keep the AppBar visible while scrolling
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: primaryColor),
                child: CustomAppBar(
                  title: "Inscription",
                  icon: IconButton(
                    onPressed: ()
{
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
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
                          const SizedBox(height: 20),
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
                                  child: BoutonRouge(text: "Suivant",                                     onPressed: _isButtonDisabled
                                      ? null
                                      : ()
                                  {
                                    if (_formKey1.currentState!.validate())
                                    {
                                      // Navigation vers la prochaine page
                                      context.push("/otp");
                                    }
                                  }),
                                ),
                                const SizedBox(height: 30),

                                // Lien Se connecter
                                InkWell(
                                  onTap: ()
{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const Placeholder(), // Remplacer par Login
                                      ),
                                    );
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


