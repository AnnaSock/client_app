import 'package:base_app/views/pages/otp_page.dart';
import 'package:base_app/views/props/code_secret_props.dart';
import 'package:base_app/views/props/otp_props.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:micro_commons/components/biometrie.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode pwdFocusNode = FocusNode();
  var pwdController = TextEditingController();
  bool _isLoading = false;
  final baseWidth = 375;
  bool _passwordVisible = false;
  String? isoCode2;
  var phoneController = TextEditingController();
  var indicatifController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child : Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0 * ffem),
          child: Container(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                /*Container(
                          alignment: Alignment.topCenter,
                          width: 38 * fem,
                          height: 4 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100 * fem),
                            color: disabledColor,
                          ),
                        ),*/
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: Colors.white),
                  child: Image.asset(
                    "assets/images/touch_logo.png",
                    package: 'micro_commons',
                    width: 50,
                    height: 70,
                  ),
                ),
                SizedBox(height: 20 * fem),
                Text(
                 "Bienvenue !",
                  style: safeGoogleFont(
                    'Lato',
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.6 * ffem / fem,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 20 * fem),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        SizedBox(height: 30 * fem),
                        Text(
                          "Code Secret",
                          style: safeGoogleFont(
                            'Lato',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.4285714286 * ffem / fem,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 5 * fem),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                obscureText: !_passwordVisible,
                                maxLength: 4,
                                style: safeGoogleFont(
                                  'Lato',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * ffem / fem,
                                  color: bodyColor,
                                ),
                                decoration: customInputDecoration(
                                  hint: "Entrez votre code secret",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      !_passwordVisible ? Icons.visibility_off : Icons.visibility,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                controller: pwdController,
                                focusNode: pwdFocusNode,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.length == 4) {
                                    FocusScope.of(context).unfocus(); // Ferme le clavier
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "AppLocalizations.of(context).login_secret_error";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5 * fem),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Text(
                                  "Code secret oublié ?",
                                  style: safeGoogleFont(
                                    'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: secondaryColor,
                                  )),
                              onTap: () {
                                  context.push(
                                      "/otp",
                                    extra: OtpProps(
                                        title: "Code Secret Oublié",
                                        routeGo: (context) => context.go(
                                            "/code-secret",
                                             extra: CodeSecretProps(
                                                 titre: "Code Secret Oublié",
                                                 sousTitre: "Changer votre code secret",
                                                 image: "assets/images/reset_code.png",
                                                 paragraphe: "Veuillez choisir et confirmer votre nouveau code secret pour vos transactions",
                                                 input1: "Nouveau code secret",
                                                 input2: "Confirmer votre code secret",
                                                 routeGo: (context) => context.go("/login")
                                             )
                                        ))
                                  );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10 * fem),
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          width: double.infinity,
                          child: BoutonRouge(text: "Se connecter", onPressed: () => {
                            showBiometricActivationModal(
                                context,
                                onActivate: ()
                                {
                                  context.goNamed("walletHome");
                                },
                                onLater: ()
                                {
                                })

                          }),
                        ),
                        /*SizedBox(height: 20 * fem),

                                InkWell(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).sign_up_text,
                                          style: safeGoogleFont(
                                            'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: hintColor
                                          ),
                                        ),
                                        SizedBox(height: 5 * fem),
                                        Text(
                                          AppLocalizations.of(context).login_create_account,
                                          style: safeGoogleFont(
                                            'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            decorationThickness: 0.8,
                                            //height: 5,
                                            color: primaryColor
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUpStep1()));
                                  },
                                ),*/
                        SizedBox(height: 50 * fem),
                        /*isBiometricSupported
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 60 * ffem,
                                              padding: const EdgeInsets.only(right: 8),
                                              child: InkWell(
                                                onTap: () {
                                                 //print"onTap firstView $firstView");
                                                  if (isBiometricEnabled && firstView) {
                                                    _authenticateWithBiometrics(context, _bloc, true);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                  srcIconFingeprint,
                                                  package: 'common_dependencies',
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (isBiometricEnabled && firstView) {
                                                  _authenticateWithBiometrics(context, _bloc, true);
                                                }
                                              },
                                              child: Text(
                                                AppLocalizations.of(context).face_id_touch_id,
                                                style: safeGoogleFont(
                                                  'Lato',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: disabledColor,
                                                ),
                                              ),
                                            ),
                                            *//*Switch(
                                              value: false, // ou une variable booléenne
                                              onChanged: (bool value) {
                                                // Action à faire lors du changement d'état
                                              },
                                              activeColor: Colors.green, // Couleur quand activé
                                              inactiveThumbColor: Colors.white,
                                              inactiveTrackColor: Colors.grey.shade300,
                                            ),*//*

                                            Container(
                                              width: 60 * ffem,
                                              child: Transform.scale(
                                                scale: 0.6,
                                                child: Switch(
                                                  trackOutlineWidth: WidgetStatePropertyAll(0.0),
                                                  trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                                                  thumbIcon: WidgetStateProperty.all(Icon(Icons.circle_rounded, color: whiteColor,)),
                                                  padding:EdgeInsets.zero,
                                                  inactiveThumbColor: whiteColor,
                                                  inactiveTrackColor: toggleBackgroundColor.withOpacity(0.16),
                                                  activeColor: whiteColor,
                                                  activeTrackColor: primaryColor,
                                                  value: isBiometricChecked,
                                                  onChanged: (bool value) async {
                                                    if (phoneController.text.isEmpty || (!isNumberValid && !isBiometricChecked)) {
                                                      _showSnackBar(AppLocalizations.of(context)!.biometric_error_phone_number);
                                                      return;
                                                    }
                                                    setState(() {
                                                      _isLoading = false;
                                                      firstView = false;
                                                      if (!value) {
                                                        isBiometricChecked = value;
                                                      }
                                                     //print"isBiometricChecked $isBiometricChecked");
                                                    });
                                                    if (value == false) {
                                                      isBiometricEnabled = false;
                                                      await secureStorage.write(key: 'biometric_enabled', value: 'false');
                                                    } else {
                                                      _authenticateWithBiometrics(context, _bloc, false);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),*/
                      ],
                    ),
                  ),
                )
              ],
              ),
            ),
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.help, color: whiteColor, size: 24),
        onPressed: () {
          // Navigator.pushNamed(context, Routes.loginGlobal.value);
          showSupportBottomSheet(context);
        },
      ),*/

        floatingActionButton: Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.live_help_rounded, color: Colors.white, size: 20,),
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }

}
