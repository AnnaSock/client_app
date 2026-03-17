import 'package:base_app/presentation/props/code_secret_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/components/bouton_rouge.dart';
import 'package:micro_commons/components/custom_sliver_app_bar.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';
import 'package:micro_commons/utils/void.dart';
import 'package:micro_commons/utils/espacement.dart';
import 'package:loading_animation_widget/src/build_loading_animation.dart';


class CodeSecretPage extends StatefulWidget
{
  final CodeSecretProps props;
  const CodeSecretPage({super.key , required this.props});

  @override
  State<CodeSecretPage> createState() => _CodeSecretPageState();
}

class _CodeSecretPageState extends State<CodeSecretPage>
{
  final formKey3 = GlobalKey<FormState>();
  final baseWidth = 375;
  String? whichLanguage, whichCountry, phoneLocation = "SN";

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final bool _isLoading = false;
  bool isCGUChecked = false;
  bool isBiometricSupported = false;

  bool formIsValid = false;
  final AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

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
              title: widget.props.titre,
            ),
               
            SliverList(
                   delegate: SliverChildListDelegate([
                     Container(
                         height: MediaQuery.of(context).size.height,
                         alignment: Alignment.topCenter,
                         padding: EdgeInsets.fromLTRB(12, 12, 12, 30 * fem),
                         decoration: const BoxDecoration(
                           color: whiteColor,
                         ),
                       child: SingleChildScrollView(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Form(
                               key: formKey3,
                               autovalidateMode: _autoValidateMode,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     padding:
                                     const EdgeInsets.only(top: 5, left: 10, bottom: 30),
                                     alignment: Alignment.topCenter,
                                     child: Text(
                                       widget.props.sousTitre,
                                       style: safeGoogleFont(
                                         'Lato',
                                         fontSize: 18,
                                         fontWeight: FontWeight.bold,
                                         color: bodyColor,
                                       ),
                                       textAlign: TextAlign.left,
                                     ),
                                   ),
                                   Stack(children: [
                                     Container(
                                       margin: EdgeInsets.fromLTRB(0 * fem,
                                           0 * fem, 0 * fem, 12.54 * fem),
                                       alignment: Alignment.topCenter,
                                       child: SizedBox(
                                         width: 100 * fem,
                                         height: 100.50 * fem,
                                         child: Image.asset(
                                           package: 'micro_commons',
                                           widget.props.image,
                                           width: 60 * fem,
                                           height: 120 * fem,
                                         ),
                                       ),
                                     ),
                                   ]),
                                   10.h,
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Wrap(
                                       alignment: WrapAlignment.center,
                                       children: [
                                         Text(
                                           widget.props.paragraphe,
                                           style: TextStyle(
                                             color: hintColor,
                                             fontSize: 15 * fem,
                                             fontWeight: FontWeight.w400,
                                           ),
                                           textAlign: TextAlign.center,
                                         ),
                                       ],
                                     ),
                                   ),
                                   20.h,
                                   Text(
                                     widget.props.input1,
                                     style: safeGoogleFont(
                                       'Lato',
                                       fontSize: 14 * ffem,
                                       fontWeight: FontWeight.w500,
                                       height: 1.43 * ffem / fem,
                                       color: primaryColor,
                                     ),
                                   ),
                                   5.h,
                                   TextFormField(
                                     style:
                                     const TextStyle(color: Colors.black),
                                     decoration: customInputDecoration(
                                       prefixIcon: Icons.lock_outline,
                                       suffixIcon: IconButton(
                                         icon: Icon(_isPasswordVisible
                                             ? Icons.visibility
                                             : Icons.visibility_off),
                                         onPressed: ()
                             {
                                           setState(()
                             {
                                             _isPasswordVisible =
                                             !_isPasswordVisible;
                                           });
                                         },
                                       ),
                                     ),
                                     controller: passwordController,
                                     focusNode: passwordFocusNode,
                                     maxLength:
                                     4, // Limiter la longueur du mot de passe à 4 chiffres
                                     keyboardType: TextInputType
                                         .number, // Clavier numérique pour les chiffres
                                     obscureText:
                                     !_isPasswordVisible, // Masquer le mot de passe si _isPasswordVisible est faux
                                     onChanged: (value)
                             {
                                       // Déclencher la validation du formulaire
                                       if (confirmPasswordController.text.isNotEmpty)
                             {
                                         formKey3.currentState?.validate();
                                       }
                                     },
                                     validator: validatePassword,
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter
                                           .digitsOnly, // Autoriser uniquement les chiffres
                                     ],
                                   ),
                                   Wrap(
                                     alignment: WrapAlignment.center,
                                     children: [
                                       Text(
                                         "Ne pas utiliser des chiffres répétitifs ou successifs exemple (2222, 1234).",
                                         style: TextStyle(
                                           color: bodyColor,
                                           fontSize: 11 * fem,
                                           fontWeight: FontWeight.w400,
                                         ),
                                         textAlign: TextAlign.start,
                                       ),
                                     ],
                                   ),
                                   20.h,
                                   Text(
                                     widget.props.input2,
                                     style: safeGoogleFont(
                                       'Lato',
                                       fontSize: 14 * ffem,
                                       fontWeight: FontWeight.w500,
                                       height: 1.43 * ffem / fem,
                                       color: primaryColor,
                                     ),
                                   ),
                                   5.h,
                                   TextFormField(
                                     style: const TextStyle(color: Colors.black),
                                     decoration: customInputDecoration(
                                       prefixIcon: Icons.lock_outline,
                                       suffixIcon: IconButton(
                                         icon: Icon(_isConfirmPasswordVisible
                                             ? Icons.visibility
                                             : Icons.visibility_off),
                                         onPressed: ()
                             {
                                           setState(()
                             {
                                             _isConfirmPasswordVisible =
                                             !_isConfirmPasswordVisible;
                                           });
                                         },
                                       ),
                                     ),
                                     controller: confirmPasswordController,
                                     focusNode: confirmPasswordFocusNode,
                                     maxLength:
                                     4, // Limiter la longueur à 4 chiffres
                                     keyboardType: TextInputType
                                         .number, // Clavier numérique pour les chiffres
                                     obscureText:
                                     !_isConfirmPasswordVisible, // Masquer le mot de passe si _isConfirmPasswordVisible est faux
                                     onChanged: (value)
                             {
                                       if (value.length < 4 && formIsValid)
                             {
                                         setState(()
                             {
                                           formIsValid = false;
                                         });
                                       }
                                     },
                                     validator: (value)
                             {
                                       if (value == null || value.isEmpty)
                             {
                                         return "AppLocalizations.of(context).phone_number_error";
                                       }
                                       if (value.length == 4 && passwordController.text != value)
                             {
                                         return "Veuillez renseigner le meme code secret";
                                       } else if (value.length == 4 && passwordController.text == value)
                             {
                                         WidgetsBinding.instance.addPostFrameCallback((_)
                             {
                                           if (mounted && !formIsValid)
                             {
                                             setState(()
                             {
                                               formIsValid = true;
                                             });
                                           }
                                         });
                                       }
                             
                                       return null;
                                     },
                                     inputFormatters: <TextInputFormatter>[
                                       FilteringTextInputFormatter
                                           .digitsOnly, // Autoriser uniquement les chiffres
                                     ],
                                   ),
                                   10.h,
                                   const SizedBox(height: 20),
                                   Container(
                                     padding: const EdgeInsets.only(top: 20, bottom: 5),
                                     width: double.infinity,
                                     height: 70,
                                     child: BoutonRouge(text: "Confirmer", onPressed: () => widget.props.routeGo(context)),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       )
                     )
                   ])
            )
            
               
            

          ],
        ),
      ),
    );
  }
}


