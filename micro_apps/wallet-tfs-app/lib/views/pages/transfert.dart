import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/enum.dart';
import 'package:micro_commons/models/uemoa_pays.dart';
import 'package:micro_commons/utils/util.dart';

class TransfertTfsSegment extends StatefulWidget {

  const TransfertTfsSegment({super.key});

  @override
  State<TransfertTfsSegment> createState() => _TransfertTfsSegmentState();
}

class _TransfertTfsSegmentState extends State<TransfertTfsSegment> {
  final baseWidth = 375;
  final _formKey = GlobalKey<FormState>();
  List<UEMOAPays> listPays = UEMOAPays.liste;
  List<UEMOAPays> listPaysCrossBorder = [];
  late String? whichCountryLang;
  late FocusNode displayedPaysFromFocus = FocusNode();
  late FocusNode displayedPaysToFocus = FocusNode();
  var paysController = TextEditingController();
  var phoneController = TextEditingController();
  var amountController = TextEditingController();
  var totalAmountController = TextEditingController();
  var emailController = TextEditingController();
  var codeOtpController = TextEditingController();
  var phoneFromController = TextEditingController();
  var phoneToController = TextEditingController();
  var indicatifFromController = TextEditingController();
  var indicatifToController = TextEditingController();
  var indicatifFrom = "221";
  var indicatifTo = "221";
  String? accountPhoneNumber, accountEmail;
  bool _isLoading = false;
  bool _isTransfertLoading = false;

  int biometricAttemptCount = 0;
  final int maxBiometricAttempts = 3; // Max attempts allowed
  bool isAuthenticating = false;
  FocusNode paysFromFocusNode = FocusNode();
  FocusNode paysToFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode totalAmountFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode codeOtpFocusNode = FocusNode();
  FocusNode phoneToFocusNode = FocusNode();
  FocusNode phoneFromFocusNode = FocusNode();
  FocusNode indicatifToFocusNode = FocusNode();
  bool includeFees = false;
  String? message = "";
  int? status = 0;
  String? paymentUrl = "";
  String? currencyFrom = "F";
  String? currencyTo = "";
  double? fees;
  double? receivedAmount = 0;
  double? totalAmount = 0;
  bool hasAddedOns = false;
  bool hasEmail = false;
  bool isEmailChecked = true;
  bool isPaymentByCard = false;
  bool serviceSave = false;
  bool loaded = false;
  String? whichLanguage, whichCountry, phoneLocation = "SN";
  int? areaCode;
  final bool _isAuthenticating = false;
  final bool _isSuccess = false;
  late double taxes = 0;

  //final authAnalyticsService = AuthAnalyticsService(AnalyticService());
  String? amountError; // dans ton State
  String? phoneNumberFromFormat;
  String? phoneNumberFormat;



  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return  Text("anna");
      /*SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // De (Services from)
                  Text(
                      "De",
                      style: CustomTextStyle.titleLabelTextStyle),
                  SizedBox(height: 5 * fem),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 12,
                        child: DropdownButtonFormField(
                          dropdownColor: const Color(0xFFF5F6FF),
                          isExpanded: true,
                          items: listPaysCrossBorder.map<DropdownMenuItem<UEMOAPays>>((UEMOAPays? country) {
                            return DropdownMenuItem<UEMOAPays>(
                              value: country,
                              child: Row(
                                children: [
                                  Center(
                                    child: country?.iso != null
                                        ? Image(
                                      height: 20,
                                      width: 20,
                                      image: AssetImage(
                                        "assets/images/${country?.iso}.png",
                                        package: 'common_dependencies',
                                      ),
                                    )
                                        : const Image(
                                      height: 20,
                                      width: 20,
                                      image: AssetImage(
                                        "assets/images/unavailable.png",
                                        package: 'common_dependencies',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.5 * fem),
                                  Text(
                                    country?.iso3 ?? "SEN",
                                    style: safeGoogleFont(
                                      'Lato',
                                      fontSize: 13.5 * fem,
                                      fontWeight: FontWeight.w500,
                                      color: bodyColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          value: selectedPaysCrossBorder,
                          focusNode: paysFromFocusNode,
                          onChanged: (newValue) {
                          },
                          decoration: customInputDecoration(radius: "left", bgColor: const Color(0xFFF5F6FF)),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: servicesListFrom.map<DropdownMenuItem<Service>>((Service value) {
                            return DropdownMenuItem<Service>(
                                value: value,
                                child: Row(
                                  children: [
                                    nbUtils.getServiceLogoService(value.logo, ffem, fem),
                                    const SizedBox(width: 5),
                                    Text(
                                      value.label!,
                                      style: CustomTextStyle.labelTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ));
                          }).toList(),
                          value: selectedServiceFrom,
                          onChanged: (newValue) {
                            setState(() {
                              selectedServiceFrom = newValue;
                              latestServiceFrom = newValue;
                              showOtpField = selectedServiceFrom?.code?.toUpperCase().trim().endsWith("OTP") ?? false;

                              // min/max dynamiques depuis le service sélectionné
                              minAmount = int.tryParse(newValue?.amountMinimal ?? '') ?? 100;
                              maxAmount = int.tryParse(newValue?.amountMaximal ?? '') ?? 200000;
                              phoneNumberFromFormat = newValue?.phoneNumberFormat;
                              if (newValue!.code!.endsWith("MPM_TPT") &&
                                  ((selectedService != null && selectedService!.code!.endsWith(BASE_API_URL == BASE_API_URL_DEV ? "CTC_EME" : "CCT_EME")) ||
                                      (latestService != null && latestService!.code!.endsWith("CCT_EME")))) {
                                phoneFromController.text = formatPhoneNumberUser2(phoneNumberFrom, whichCountry!);
                                isPhoneFromEnabled = false;
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 1; // garde dynamique
                              } else if (newValue.code!.endsWith("MPM_ORB")) {
                                phoneFromController.text = formatPhoneNumberUser2(phoneNumberFrom, whichCountry!);
                                isPhoneFromEnabled = false;
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 100;
                              } else if (selectedService != null && (selectedService == serviceAlias || selectedService == serviceIban || selectedService == serviceCompte)) {
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 1;
                              } else {
                                isPhoneFromEnabled = true;
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 100;
                              }
                            });
                          },
                          decoration: customInputDecoration(radius: "right"),
                        ),
                      ),
                    ],
                  ),

                  // Numéro de téléphone De
                  SizedBox(height: 10 * fem),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        flex: 12,
                        child: TextFormField(
                          enabled: false,
                          decoration: customInputDecoration(radius: "left", bgColor: const Color(0xFFF5F6FF)),
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: bodyColor),
                          controller: indicatifFromController,
                        )),
                    Expanded(
                      flex: 25,
                      child: TextFormField(
                        controller: phoneFromController,
                        enabled: isPhoneFromEnabled,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: customInputDecoration(
                            suffixIcon: TextButton(
                              onPressed: () {
                                Navigator.push<String>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>  BlocProvider(
                                        create: (BuildContext context)=> ContactBloc()..add(const ContactListEvent(null)),
                                        child: const ContactPage()
                                    ),

                                  ),
                                ).then((numero) {
                                  if (numero != null) {
                                    phoneFromController.text = numero;
                                  }
                                });
                              },
                              child: Image.asset("assets/images/icon_contact.png", package: "common_dependencies", width: 22, height: 22),
                            ),
                            hint: AppLocalizations.of(context).phone_number,
                            colorHint: const Color(0xFFB7BFCF),
                            radius: "right")
                            .copyWith(
                          errorStyle: const TextStyle(fontSize: 0, height: 0), // on masque l'erreur interne
                        ),
                        keyboardType: TextInputType.text,
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: phoneFromFocusNode,
                        onTap: () {
                          if (phoneFromController.text.isEmpty) {
                            setState(() {
                              currentPage = 0;
                            });
                            loadContacts(context); // Affiche les contacts même si champ vide
                          }
                        },
                        onChanged: (phone) {
                          if (phone.isNotEmpty) {
                            scrollController.removeListener(_scrollListener);
                            filterContact(contacts, phone.replaceAll(" ", "")).then((filteredContacts) {
                              setState(() {
                                displayedContacts = filteredContacts;
                              });
                            }).catchError((error) {
                              logger.e("Error filtering contacts: $error");
                            });
                          } else {
                            currentPage = 0;
                            loadContacts(context);
                          }
                          final formatted = formatPhoneNumberUser2(phone, whichCountry!);

                          if (formatted != phone) {
                            phoneFromController.value = TextEditingValue(
                              text: formatted,
                              selection: TextSelection.collapsed(offset: formatted.length),
                            );
                          }
                        },
                        validator: (value) {
                          var phone = value?.replaceAll(RegExp(r'\s+'), '');
                          if (phone == null || phone.isEmpty) {
                            return AppLocalizations.of(context).verif_input;
                          }

                          // Verifier le format dynamiue du service
                          if (!RegExp(phoneNumberFromFormat ?? r'.*').hasMatch(phone)) {
                            return AppLocalizations.of(context).verif_input;
                          }
                          //else {
                          // Normalise le numéro
                          //String? formatted = formatPhone(phone);
                          //if (formatted == null) {
                          //  return AppLocalizations.of(context).verif_input;
                          //} else {
                          // Remplace la valeur  avec la version formatée
                          //  phoneFromController.text = formatted;
                          //}
                          //}

                          return null;
                        },
                      ),
                    )
                  ]),
                  if (phoneFromFocusNode.hasFocus && displayedContacts.isNotEmpty) ...[
                    Container(
                      height: MediaQuery.of(context).copyWith().size.height * 0.4,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                      margin: EdgeInsets.only(top: 1 * fem),
                      decoration: customBoxDecoration(radius: BorderRadius.circular(8.0)),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: displayedContacts.length,
                        itemBuilder: (context, index) {
                          if (index < displayedContacts.length && displayedContacts.isNotEmpty) {
                            Contact contact = displayedContacts[index];
                            List<Widget> phoneTiles = [];
                            for (var phone in contact.phones) {
                              phoneTiles.add(
                                ListTile(
                                  leading: CircleAvatar(backgroundColor: lightPrimaryColor, child: const Icon(Icons.person, color: primaryColor)),
                                  title: Text(contact.displayName),
                                  subtitle: Text(contact.phones.isNotEmpty ? phone.number : ""),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                  dense: true,
                                  onTap: () {
                                    phoneFromController.text = contact.phones.isNotEmpty ? formatPhoneNumberUser2(phone.number, whichCountry!).toString() : "";
                                    setState(() {
                                      currentPage = 0;
                                    });
                                    loadContacts(context); // ✅ recharge la liste complète après sélection
                                    phoneFromFocusNode.unfocus(); // Hide keyboard
                                  },
                                ),
                              );
                            }
                            return Column(
                              children: phoneTiles,
                            );
                          } else if (currentPage < (contacts.length / contactsPerPage)) {
                            // loadMoreContacts(); // Load more contacts when nearing the end
                            return Container(
                                margin: EdgeInsets.only(top: 5 * fem),
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)!.contact_not_found, style: CustomTextStyle.descriptionTextStyle));
                          } else {
                            return Container(
                                margin: EdgeInsets.only(top: 5 * fem),
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)!.contact_not_found, style: CustomTextStyle.superTitleTextStyle)); // Placeholder to avoid rendering extra space
                          }
                        },
                      ),
                    ),
                  ],
                  if (showOtpField) SizedBox(height: 15 * fem),
                  if (showOtpField)
                    TextFormField(
                      decoration: customInputDecoration(
                        labelText: (whichCountry != null && whichCountry == "SN")
                            ? "${AppLocalizations.of(context)!.otp_code} #144#391#"
                            : (whichCountry != null && whichCountry == "BF")
                            ? "${AppLocalizations.of(context)!.otp_code} *144*4*6#"
                            : (whichCountry != null && whichCountry == "GN")
                            ? "${AppLocalizations.of(context)!.otp_code} *144*4*2*1#"
                            : (whichCountry != null && whichCountry == "CI")
                            ? "${AppLocalizations.of(context)!.otp_code} #144*82#"
                            : AppLocalizations.of(context)!.otp_code,
                      ),
                      controller: codeOtpController,
                      focusNode: codeOtpFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez saisir le code OTP";
                        } else if (whichCountry != null && (whichCountry == "SN" || whichCountry == "BF") && value.length != 6) {
                          return "Veuillez saisir le code OTP";
                        }
                        return null;
                      },
                    ),

                  // Vers (Services Vers)
                  SizedBox(height: 15 * fem),
                  Text(AppLocalizations.of(context)!.to, style: CustomTextStyle.titleLabelTextStyle),
                  SizedBox(height: 5 * fem),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 12,
                        child: DropdownButtonFormField(
                          dropdownColor: const Color(0xFFF5F6FF),
                          isExpanded: true,
                          items: listPaysCrossBorder.map<DropdownMenuItem<UEMOAPays>>((UEMOAPays? country) {
                            return DropdownMenuItem<UEMOAPays>(
                              value: country,
                              child: Row(
                                children: [
                                  Center(
                                    child: country?.iso != null
                                        ? Image(
                                      height: 20 * fem,
                                      width: 20 * fem,
                                      image: AssetImage(
                                        "assets/images/${country?.iso}.png",
                                        package: 'common_dependencies',
                                      ),
                                    )
                                        : Image(
                                      height: 20 * fem,
                                      width: 20 * fem,
                                      image: const AssetImage(
                                        "assets/images/unavailable.png",
                                        package: 'common_dependencies',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.5 * fem),
                                  Text(
                                    country!.iso3!,
                                    style: safeGoogleFont(
                                      'Lato',
                                      fontSize: 13.5 * fem,
                                      fontWeight: FontWeight.w500,
                                      color: bodyColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          value: selectedPaysCrossBorder,
                          focusNode: paysToFocusNode,
                          onChanged: (newValue) {
                            setState(() {
                              selectedPaysCrossBorder = newValue;
                              currentType = "DEPOSIT";
                              whichCountry = newValue?.iso;
                              indicatifFromController.text = newValue!.phoneCode;
                              indicatifToController.text = newValue.phoneCode;
                            });
                            serviceInterneBloc.add(GetServiceByType(typeService: currentType, countryCode: whichCountry));
                          },
                          decoration: customInputDecoration(radius: "left", bgColor: const Color(0xFFF5F6FF)),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: servicesList.map<DropdownMenuItem<Service>>((Service value) {
                            return DropdownMenuItem<Service>(
                                value: value,
                                child: Row(
                                  children: [
                                    nbUtils.getServiceLogoService(value.logo, ffem, fem),
                                    const SizedBox(width: 5),
                                    Text(
                                      value.label!,
                                      style: CustomTextStyle.labelTextStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ));
                          }).toList(),
                          value: selectedService,
                          onChanged: (newValue) {
                            setState(() {
                              selectedService = newValue;
                              latestService = newValue;

                              // min/max dynamiques depuis le service sélectionné, conversion en double
                              minAmount = int.tryParse(newValue?.amountMinimal ?? '') ?? 100;
                              maxAmount = int.tryParse(newValue?.amountMaximal ?? '') ?? 200000;
                              phoneNumberFormat = newValue?.phoneNumberFormat;
                              if (newValue!.code!.endsWith(BASE_API_URL == BASE_API_URL_DEV ? "CTC_EME" : "CCT_EME") &&
                                  ((selectedServiceFrom != null && selectedServiceFrom!.code!.endsWith("MPM_TPT")) ||
                                      (latestServiceFrom != null && latestServiceFrom!.code!.endsWith("MPM_TPT")))) {
                                phoneFromController.text = formatPhoneNumberUser2(phoneNumberFrom, whichCountry!);
                                isPhoneFromEnabled = false;
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 1;
                              } else if (selectedService != null && (selectedService == serviceAlias || selectedService == serviceIban || selectedService == serviceCompte)) {
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 1;
                              } else {
                                isPhoneFromEnabled = true;
                                minAmount = int.tryParse(newValue.amountMinimal ?? '') ?? 100;
                              }
                            });
                          },
                          decoration: customInputDecoration(radius: "right"),
                        ),
                      ),
                    ],
                  ),

                  // Numéro de téléphone Vers
                  SizedBox(height: 10 * fem),

                  if (selectedService == serviceAlias) ...[
                    _buildFormContent(0),
                  ] else if (selectedService == serviceIban) ...[
                    _buildFormContent(1),
                  ] else if (selectedService == serviceCompte) ...[
                    _buildFormContent(2),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 12,
                          child: TextFormField(
                            enabled: false,
                            decoration: customInputDecoration(radius: "left", bgColor: const Color(0xFFF5F6FF)),
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: bodyColor),
                            controller: indicatifToController,
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: TextFormField(
                            //autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: customInputDecoration(
                              suffixIcon: TextButton(
                                onPressed: () {
                                  Navigator.push<String>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>  BlocProvider(
                                          create: (BuildContext context)=> ContactBloc()..add(const ContactListEvent(null)),
                                          child: const ContactPage()
                                      ),

                                    ),
                                  ).then((numero) {
                                    if (numero != null) {
                                      phoneToController.text = numero;
                                    }
                                  });
                                },
                                child: Image.asset("assets/images/icon_contact.png", package: "common_dependencies", width: 22, height: 22),
                              ),
                              hint: AppLocalizations.of(context)!.phone_number,
                              radius: "right",
                            ).copyWith(
                              errorStyle: const TextStyle(fontSize: 0, height: 0), // on masque l'erreur interne
                            ),
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            controller: phoneToController,
                            focusNode: phoneToFocusNode,
                            autovalidateMode: _autoValidateMode,
                            validator: (value) {
                              var phone = value?.replaceAll(RegExp(r'\s+'), '');
                              if (phone == null || phone.isEmpty) {
                                return AppLocalizations.of(context).verif_input;
                              }
                              final cleanedFrom = phoneFromController.text.replaceAll(RegExp(r'[^\d.]'), '');
                              final cleanedTo = phoneToController.text.replaceAll(RegExp(r'[^\d.]'), '');

                              final sameService = selectedService?.logo == selectedServiceFrom?.logo;
                              final samePhone = cleanedFrom == cleanedTo && cleanedTo.isNotEmpty;

                              if (sameService && samePhone) {
                                return AppLocalizations.of(context).verif_recipient_phone_number;
                              }
                              // Verifier le format dynamiue du service
                              if (!RegExp(phoneNumberFormat ?? r'.*').hasMatch(phone)) {
                                return AppLocalizations.of(context).verif_recipient_phone_number;
                              }
                              //else {
                              // Normalise le numéro
                              //  String? formatted = formatPhone(phone);
                              //  if (formatted == null) {
                              //    return AppLocalizations.of(context).verif_recipient_phone_number;
                              //  } else {
                              // Remplace la valeur  avec la version formatée
                              //    phoneFromController.text = formatted;
                              //  }
                              //}

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (phoneToFocusNode.hasFocus && displayedContacts.isNotEmpty) ...[
                    Container(
                      height: MediaQuery.of(context).copyWith().size.height * 0.4,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                      margin: EdgeInsets.only(top: 1 * fem),
                      decoration: customBoxDecoration(radius: BorderRadius.circular(8.0)),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: displayedContacts.length,
                        itemBuilder: (context, index) {
                          if (index < displayedContacts.length && displayedContacts.isNotEmpty) {
                            Contact contact = displayedContacts[index];
                            List<Widget> phoneTiles = [];
                            for (var phone in contact.phones) {
                              phoneTiles.add(
                                ListTile(
                                  leading: CircleAvatar(backgroundColor: lightPrimaryColor, child: const Icon(Icons.person, color: primaryColor)),
                                  title: Text(contact.displayName),
                                  subtitle: Text(contact.phones.isNotEmpty ? phone.number : ""),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                  dense: true,
                                  onTap: () {
                                    phoneToController.text = contact.phones.isNotEmpty ? formatPhoneNumberUser2(phone.number, whichCountry!).toString() : "";
                                    setState(() {
                                      currentPage = 0;
                                    });
                                    loadContacts(context);
                                    phoneToFocusNode.unfocus(); // Hide keyboard
                                  },
                                ),
                              );
                            }
                            return Column(
                              children: phoneTiles,
                            );
                          } else if (currentPage < (contacts.length / contactsPerPage)) {
                            // loadMoreContacts(); // Load more contacts when nearing the end
                            return Container(
                                margin: EdgeInsets.only(top: 5 * fem),
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)!.contact_not_found, style: CustomTextStyle.descriptionTextStyle));
                          } else {
                            return Container(
                                margin: EdgeInsets.only(top: 5 * fem),
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)!.contact_not_found, style: CustomTextStyle.superTitleTextStyle)); // Placeholder to avoid rendering extra space
                          }
                        },
                      ),
                    ),
                  ],
                  // Montant
                  SizedBox(height: 15 * fem),
                  TextFormField(
                    inputFormatters: [
                      ThousandSeparatorInputFormatter(),
                    ],
                    decoration: customInputDecoration(
                      suffixIcon: Container(
                        width: 38,
                        height: 36,
                        margin: const EdgeInsets.only(right: 1.5, top: 1.5, bottom: 1.5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xffF5F6FF),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                          /*border: Border(
                                        top: BorderSide(color: amountFocusNode.hasFocus ? primaryColor : const Color(0x80D0D5DD), width: 1),
                                        right: BorderSide(color: amountFocusNode.hasFocus ? primaryColor : const Color(0x80D0D5DD), width: 1),
                                        bottom: BorderSide(color: amountFocusNode.hasFocus ? primaryColor : const Color(0x80D0D5DD), width: 1),
                                      ),*/
                        ),
                        /*decoration: const ShapeDecoration(
                                        color: Color(0xFFF5F6FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ),
                                        ),
                                      ),*/
                        child: Text(
                          getCurrencySuffix(currencyFrom!),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF344054),
                            fontSize: 15,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //suffixText: getCurrencySuffix(currencyFrom!),
                      //suffixfontSize: 12,
                      hint: AppLocalizations.of(context).amount,
                      colorHint: const Color(0xFFB7BFCF),
                    ),
                    controller: amountController,
                    focusNode: amountFocusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final amountStr = value?.replaceAll(RegExp(r'\s+'), '');
                      if (amountStr == null || amountStr.isEmpty) {
                        return AppLocalizations.of(context).verif_input;
                      }

                      final enteredValue = double.tryParse(amountStr);
                      if (enteredValue == null || enteredValue == 0) {
                        return AppLocalizations.of(context).verif_input;
                      }

                      // min/max dynamiques depuis le service
                      final int min = int.tryParse(selectedService?.amountMinimal ?? '') ?? 100;
                      final int max = int.tryParse(selectedService?.amountMaximal ?? '') ?? 200000;
                      if (enteredValue < min || enteredValue > max) {
                        return AppLocalizations.of(context)!.amount_error(min, max);
                      }

                      if(selectedServiceFrom != null && selectedServiceFrom!.code!.endsWith("MPM_TPT")
                          && phoneNumberFrom != null && phoneNumberFrom.contains(phoneFromController.text.replaceAll(' ', ''))){
                        if (solde == null || enteredValue > solde!) {
                          return AppLocalizations.of(context).solde_insuffisant_transfert;
                        }
                      }
                      return null;
                    },
                  ),

                  // Btn Envoyer
                  SizedBox(height: 20 * fem),
                  AnimatedPadding(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40),
                      child: Center(
                        child: SizedBox(
                            key: _buttonKey,
                            height: 40 * fem,
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: ElevatedButton.icon(
                                icon: _isTransfertLoading
                                    ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: LoadingAnimationWidget.flickr(
                                    leftDotColor: primaryColor,
                                    rightDotColor: secondaryColor,
                                    size: 30,
                                  ),
                                )
                                    : const Icon(null),
                                style: ButtonStyle(
                                  backgroundColor: _isLoading ? WidgetStateProperty.all<Color>(secondaryColor.withOpacity(0.8)) : WidgetStateProperty.all<Color>(secondaryColor),
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                label: Text(
                                  AppLocalizations.of(context)!.envoyer,
                                  style: safeGoogleFont('Lato', fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                                onPressed: _isTransfertLoading ? null : () async {
                                  if (!_checkSameServicesAndPhone()) return;

                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _isTransfertLoading = true;
                                    });

                                    String? amountBefore = amountController.text.replaceAll(RegExp(r'\s+'), '');
                                    double? amount = double.tryParse(amountBefore);

                                    if (amount == null) {
                                      setState(() => _isTransfertLoading = false);
                                      return;
                                    }

                                    try {

                                      if (selectedService == serviceAlias || selectedService == serviceIban || selectedService == serviceCompte) {
                                        fees = 0;
                                        taxes = 0;
                                        receivedAmount = amount;
                                        totalAmount = amount;
                                        if (selectedService == serviceAlias) {
                                          var cleanAlias = cleanPhone(aliasController.text, indicatifToController.text);
                                          serviceInterneBloc.add(SearchAlias(alias: cleanAlias));
                                        } else if (selectedService == serviceIban) {
                                          serviceInterneBloc.add(SearchIban(iban: ibanController.text, bankName: selectedParticipant?.nomMembre));
                                        } else if (selectedService == serviceCompte) {
                                          serviceInterneBloc.add(SearchAccountPI(account: accountController.text, institutionCode: selectedParticipant?.codeMembre));
                                        }
                                        return;
                                      }

                                      // --- CAS 2 : TRANSFERT VERS PARTENAIRE / EME (Via BLOC) ---
                                      // Si c'est un service EME (Orange, Wave, etc.)
                                      else if (!selectedService!.code!.contains(BASE_API_URL == BASE_API_URL_DEV ? "CTC_EME" : "CCT_EME") &&
                                          !selectedServiceFrom!.code!.contains("MPM_TPT")) {

                                        final rawAmount = amountController.text.replaceAll(RegExp(r'\s+'), '');
                                        serviceInterneBloc.add(GetFeesChange(
                                            requestFeesChange: RequestFeesChange(
                                                amount: rawAmount.toInt(),
                                                withdrawalServiceCode: selectedServiceFrom!.code,
                                                depositServiceCode: selectedService!.code)));
                                        return; // Le récap sera géré par le BlocListener (state is SuccessFeesChange)
                                      }

                                      //  CAS 3  TRANSFERT INTERNE ---
                                      else {
                                        Map<String, double>? result = await getFrais(amount);

                                        if (result == null) {
                                          print(" Debug: result est null, arrêt du processus");
                                          setState(() {
                                            _isLoading = false;
                                            _isTransfertLoading = false;
                                          });
                                          return;
                                        }

                                        setState(() {
                                          fees = result['fees'];
                                          taxes = result['taxes']!;

                                          double charges = (fees! + taxes!);
                                          if (includeFees) {
                                            receivedAmount = amount - charges;
                                            totalAmount = amount;
                                          } else {
                                            receivedAmount = amount;
                                            totalAmount = amount + charges;
                                          }
                                        });

                                        //  VÉRIFICATION SOLDE
                                        if (selectedServiceFrom?.code?.endsWith("MPM_TPT") == true) {
                                          if (solde == null || totalAmount! > solde!) {
                                            // ... ton SnackBar ...
                                            setState(() {
                                              _isLoading = false;
                                              _isTransfertLoading = false;
                                            });
                                            return; // Si on sort ici, le récap ne s'affichera JAMAIS
                                          }
                                        }

                                        print("📱 Debug: Tentative d'affichage du BottomSheet...");

                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          _showRecapBottomSheetMessage(context, [
                                            InfoLine(
                                              AppLocalizations.of(context)!.from,
                                              selectedServiceFrom?.logo,
                                              phoneFromController.text,
                                            ),
                                            InfoLine(
                                              AppLocalizations.of(context)!.to,
                                              selectedService?.logo,
                                              phoneToController.text,
                                            ),
                                          ], null);

                                          // IMPORTANT : On remet à false ICI, après l'ouverture
                                          setState(() {
                                            _isLoading = false;
                                            _isTransfertLoading = false;
                                          });
                                          print("✨ Debug: Recap affiché et loading stoppé");
                                        }
                                        );
                                      }
                                    } catch (e) {
                                      setState(() {
                                        _isLoading = false;
                                        _isTransfertLoading = false;
                                      });
                                      logger.e("ERREUR TRANSFERT", error: e);
                                    }
                                  }
                                })),
                      )),
                ],
              )),
        ],
      ),
    )*/;
  }
}


