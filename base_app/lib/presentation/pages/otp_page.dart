
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/clavier_numeric.dart';
import 'package:micro_commons/components/custom_sliver_app_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';
import 'package:micro_commons/utils/void.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});
  @override
  State<OtpPage> createState() => _OtpPage();
}

class _OtpPage extends State<OtpPage>  {
  final baseWidth = 375;
  final _formKey2 = GlobalKey<FormState>();
  var codeOtpController = TextEditingController();
  FocusNode codeOtpFocusNode = FocusNode();

  Timer? _countdownTimer;
  int _remainingSeconds = 60;
  bool _isButtonEnabled = false;

  bool isFirstTime = true;
  bool _isSuccess = false;

  var identifiantController = TextEditingController();

  late String witchLanguage;
  late String witchCountry = "SN";
  var indicatif = "221";
  bool _isLoading = false;
  FocusNode identifiantFocusNode = FocusNode();
  final bool _isButtonDisabled = true;

  String? _lastClipboardContent;
  bool _isListeningForSMS = false;
  String canal = "WhatsApp";
  String? channel;
  String? _errorMessage;
  bool _isPinCompleted = false;

  @override
  void initState() {
    super.initState();
    startCountdown();


    // Démarrer l'écoute du clipboard
    _startClipboardListener();
  }



  void _checkClipboard() async {
    try {
      ClipboardData? data = await Clipboard.getData('text/plain');
      if (data != null && data.text != null) {
        String currentContent = data.text!;
        // Vérifier si le contenu a changé
        if (currentContent != _lastClipboardContent) {
          _lastClipboardContent = currentContent;

          // Extraire le code OTP s'il existe
          if (currentContent != null && currentContent.length == 4) {
            // Remplir automatiquement le champ
            codeOtpController.text = currentContent;
            await Clipboard.setData(const ClipboardData(text: ''));
          }
        }
      }
    } catch (e) {
      // Ignorer les erreurs de clipboard silencieusement
    }
  }

  void _startClipboardListener() {
    _checkClipboardPeriodically();
  }

  void _checkClipboardPeriodically() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _checkClipboard();
        _checkClipboardPeriodically(); // 🔁 Rappel pour boucle continue
      }
    });
  }



  @override
  void dispose() {
    _countdownTimer?.cancel();
    codeOtpController.dispose();
    identifiantController.dispose();
    codeOtpFocusNode.dispose();
    identifiantFocusNode.dispose();
    super.dispose();
  }

  void startCountdown() {
    if (!mounted) return; //
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isButtonEnabled = true; // Enable button after 60 seconds
          _countdownTimer?.cancel(); // Stop countdown when finished
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    witchLanguage = Localizations.localeOf(context).languageCode;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: GestureDetector(
          onTap: () => unfocus(context),
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(title: "Vérification numéro téléphone"),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: whiteColor,
                      child:  Form(
                        key: _formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem,
                                    30 * fem, 0 * fem, 22.54 * fem),
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 100 * fem,
                                  height: 100.50 * fem,
                                  child: Image.asset(
                                    package: 'micro_commons',
                                    'assets/images/code_otp.png',
                                    width: 60 * fem,
                                    height: 120 * fem,
                                  ),
                                ),
                              ),
                            Center(
                              child: SizedBox(
                                width: 327 * fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Votre code de vérification a été envoyé par",
                                      style: TextStyle(
                                          color: hintColor,
                                          fontSize: 15 * fem,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "WhatsApp au +221 78 183 26 23",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 15 * fem,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 327 * fem,
                                height: 100 * fem,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10 * fem),
                                  width: double.infinity,
                                  height: 64 * fem,
                                  child:
                                  SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Pinput(
                                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                                      //autofillHints: const [AutofillHints.oneTimeCode],
                                      controller: codeOtpController,
                                      defaultPinTheme: defaultPinTheme,
                                      separator: const SizedBox(width: 20),
                                      focusedPinTheme: focusedPinTheme,
                                      submittedPinTheme: submittedPinTheme,
                                      length:4,
                                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                      showCursor: true,
                                      onCompleted: (pin) async {},
                                      onChanged: (value) {
                                        setState(() {
                                          _isPinCompleted = value.length == 4;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //10.height,
                            if (!_isButtonEnabled && !isFirstTime)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.timer_sharp),
                                 const SizedBox(width: 5),
                                  Text(
                                    "$_remainingSeconds sec",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ],
                              ),
                            TextButton(
                              onPressed: _isButtonEnabled ? null : () {
                                // Ne rien faire quand le bouton est désactivé
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Vous n'avez pas reçu de code ?",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),

                                  if (_isButtonEnabled || isFirstTime)
                                    PopupMenuButton<String>(
                                      tooltip: "AppLocalizations.of(context).resend",
                                      color: Colors.white,
                                      onSelected: (value) async {
                                        setState(() {
                                          channel = value;
                                          _remainingSeconds = 60;
                                          _isButtonEnabled = false;
                                          isFirstTime = false;
                                          if (value == 'WHATSAPP') {
                                            canal = 'WhatsApp';
                                          } else {
                                            canal = 'SMS';
                                          }
                                        });
                                        codeOtpController.clear();
                                        startCountdown();
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'WHATSAPP',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                package: 'micro_commons',
                                                'assets/images/whatsapp.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('WhatsApp'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'SMS',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                package: 'micro_commons',
                                                'assets/images/sms.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text('SMS'),
                                            ],
                                          ),
                                        ),
                                      ],
                                      child: Row(
                                        children: [
                                          Text(
                                            "Renvoyer",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: secondaryColor,
                                              decoration: TextDecoration.underline,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Icon(Icons.arrow_drop_down, color: secondaryColor),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 30),
                              width: double.infinity,
                              child: BoutonRouge(text: "Vérifier",
                                  isDisabled: (!_isPinCompleted),
                                  onPressed: (){

                              }),
                            ),
                            const SizedBox(height: 10),
                            if (_errorMessage != null)
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(height: 20),
                            NumericKeypad(
                              controller: codeOtpController,
                              onPress: null,
                            ),
                            const SizedBox(height: 50),
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
    );
  }


}


