
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_commons/components/otp_page/pop_pup.dart';
import 'package:micro_commons/components/otp_page/pre_pin.dart';
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

  var identifiantController = TextEditingController();

  FocusNode identifiantFocusNode = FocusNode();

  String? channel;
  String? _errorMessage;
  bool _isPinCompleted = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
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
    if (!mounted) return;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isButtonEnabled = true;
          _countdownTimer?.cancel();
        }
      });
    });

  }

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
                             PrePin(fem: fem),
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

                                        });
                                        codeOtpController.clear();
                                        startCountdown();
                                      },
                                      itemBuilder: (context) => [
                                        PopPup(value: "WhatsApp", image: "whatsapp.png", text: "WHATSAPP",),
                                        PopPup(value: "Sms", image: "sms.png", text: "SMS",),
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
                                    context.push("/cgu");
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


