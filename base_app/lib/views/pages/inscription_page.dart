// ignore_for_file: depend_on_referenced_packages
import 'package:base_app/views/props/otp_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:micro_commons/blocs/inscription/inscription_bloc.dart';
import 'package:micro_commons/blocs/inscription/inscription_event.dart';
import 'package:micro_commons/blocs/inscription/inscription_state.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/custom_sliver_app_bar.dart';
import 'package:micro_core/services/firebase_service.dart';
import 'package:micro_commons/utils/colors.dart';
import 'dart:async';
import 'package:micro_commons/utils/util.dart';
import 'package:micro_commons/utils/void.dart';
import 'package:micro_commons/providers/provider.dart';

class InscriptionPage1 extends ConsumerStatefulWidget {
  const InscriptionPage1({super.key});

  @override
  ConsumerState<InscriptionPage1> createState() => _InscriptionPage1State();
}

class _InscriptionPage1State extends ConsumerState<InscriptionPage1> {
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
  String? fullPhoneNumber;
  String? whichLanguage = "SN";

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_updateButtonState);
    const defaultCountryCode = '221';
    indicatifController.text = defaultCountryCode;
    isoCode2 = "SN";
  }

  void _updateButtonState() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          _isButtonDisabled = phoneController.text.isEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    phoneController.removeListener(_updateButtonState);
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final inscriptionBloc = ref.read(inscriptionBlocProvider);

    return BlocProvider<InscriptionBloc>.value(
      value: inscriptionBloc,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: BlocListener<InscriptionBloc, InscriptionState>(
          listener: (context, state) {
            if (state is OtpSent) {
              context.push("/otp", extra: OtpProps(
                  title: "Vérification numéro téléphone",
                  routeGo: (context) => context.push("/cgu")
              ));
            } else if (state is InscriptionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: GestureDetector(
            onTap: () => unfocus(context),
            child: CustomScrollView(
              slivers: [
                const CustomSliverAppBar(title: "Inscription"),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.all(16 * fem),
                      color: whiteColor,
                      child: BlocBuilder<InscriptionBloc, InscriptionState>(
                        builder: (context, state) {
                          final isLoading = state is InscriptionLoading;
                          return SingleChildScrollView(
                            child: Form(
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
                                    validator: (value) => value == null || value.isEmpty
                                        ? "Champ obligatoire" : null,
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
                                    validator: (value) => value == null || value.isEmpty
                                        ? "Champ obligatoire" : null,
                                  ),
                                  const SizedBox(height: 20),

                                  // Numéro téléphone
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
                                    dropdownIconPosition: IconPosition.trailing,
                                    onChanged: (phone) {
                                      setState(() {
                                        fullPhoneNumber = phone.completeNumber;
                                        print("numero tapé : $fullPhoneNumber");
                                      });
                                    },
                                    onCountryChanged: (value) {
                                      setState(() {
                                        isoCode2 = value.code;
                                        indicatifController.text = value.dialCode;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  // Bouton + Loading
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: BoutonRouge(
                                      text: isLoading ? "Envoi..." : "Suivant",
                                      isDisabled: _isButtonDisabled || fullPhoneNumber == null || isLoading,
                                      onPressed: isLoading ? null : () {
                                        if (_formKey1.currentState!.validate() && fullPhoneNumber != null) {
                                          context.read<InscriptionBloc>().add(
                                              SendOtpEvent(fullPhoneNumber!)
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  if (isLoading) const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(child: CircularProgressIndicator()),
                                  ),

                                  const SizedBox(height: 30),

                                  // Se connecter
                                  InkWell(
                                    onTap: () => context.go("/home"),
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
                          );
                        },
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}