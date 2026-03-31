import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_tfs_app/views/components/balance_card.dart';
import 'package:wallet_tfs_app/views/components/custom_app_bar.dart';
import 'package:wallet_tfs_app/views/components/custom_drawer.dart';
import 'package:wallet_tfs_app/views/pages/transfert.dart';

class HomeTFSPage extends StatefulWidget
{
  final int selectedTab;
   HomeTFSPage({super.key, this.selectedTab = 0});

  @override
  State<HomeTFSPage> createState() => _HomeTFSPageState();
}

class _HomeTFSPageState extends State<HomeTFSPage> with SingleTickerProviderStateMixin
{
  final baseWidth = 375;
  String? KYC1;
  String? KYC2;
  String kycStatus = "NOT_VERIFIED";


  var indicatifController = TextEditingController();
  double fem = 1, ffem = 1;
  bool showSlider = true;
  bool isAuthenticated = false;
  String? phoneNumber;
  double? solde = 0;
  String? currency;
  String? currencyFrom = "F";
  String? secretCode;
  bool viewSolde = true;
  String? currentCode;
  String? formattedDateTime;
  String? whichCountry, phoneLocation = "SN";
  String whichCountryLang = "en";
  late TabController tabController;
  String? country = "Senegal";
  int? _selectedTab;
  int _lastSelectedTab = 0;
  static const int othersTabIndex = 5;
  static String? merchantName;
  static String? mobileNumber;
  static String? terminalLabel;
  List<String> enabledNameServices = [];
  List<String> enabledServices = [];
  String? qrCodeData;
  String? name;
  bool authenticated = false;
  bool useBiometrics = false;
  bool deactivateBiometrie = false;
  // bool _shouldAuthenticate = true;
  bool _isMounted = false;
  bool isAuthenticating = false;
  bool isBiometricsAvailable = false;
  bool isLoading = true;
  bool _isLoading = true;
  Timer? _progressTimer;
  double progress = 0.0;
  Color codeColor = primaryColor;
  bool isLoadingService = true;
  bool isConnectedToInternet = false;
  //late LocalAuthentication auth;
  StreamSubscription? _sub;
  bool isBiometricSupported = false;
  bool isBiometricChecked = false;
  bool FlagBiometrie = true;
  bool isBiometricEnabled = false;
  bool firstView = true;
  bool biometriCalled = false;
  bool isNumberValid = true;
  //bool _isSignUpOnLoginFailed = false;
  bool isFirstTime = false;
  bool isTouchIdEnabled = false;
  String? issuerAccount;
  String? _qrData;
  String? nameUser;
  List<dynamic> kyclevels = [];
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();


  List<Widget> get _widgetOptions
{

    return [
      Container(color: whiteColor, padding: const EdgeInsets.symmetric(vertical: 10), child: TransfertTfsSegment()),
      Container(
          color: whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Payement")),
      //enabledServices.isNotEmpty
      //    ?
      Container(
          color: whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Credit")),
      Container(
        color: whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("Factures"), // widget ajouté ci-dessous
      ),
    ];
  }

  void _onItemTapped(int index)
{
    if (index != othersTabIndex)
{
      setState(()
{
        _selectedTab = index;
        _lastSelectedTab = index;
      });
    } else
{
      return null;
    }
  }
  @override
  void initState()
{
    super.initState();
    _isMounted = true;
    tabController = TabController(initialIndex: _selectedTab ?? 0, length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context)
{
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        key: _homeKey,
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height * fem),
          child: CustomAppBar(
            homeKey: _homeKey,
            fem: fem,
            name: name,
          ),
        ),

        drawer: CustomDrawer(),


        body: RefreshIndicator(
          backgroundColor: whiteColor,
          color: hintColor,
          strokeWidth: 2.0,
          onRefresh: () async =>
{

          },
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 60,
              // 👆 pousse toute la liste quand le clavier apparaît
            ),
            child: ListView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16 * fem, left: MediaQuery.of(context).size.width * 0.01, right: MediaQuery.of(context).size.width * 0.01),
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Card(
                      color: bgCircleColor,
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Container montant & qr code
                            BalanceCard(
                            fem: fem,
                            solde: solde ?? 0,
                            viewSolde: viewSolde,
                            qrData: _qrData,
                            onToggleVisibility: () {
                              setState(() {
                                viewSolde = !viewSolde;
                              });
                            },
                          ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: bgCircleColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 10 * fem, left: 10 * fem, right: 10 * fem),
                                padding: EdgeInsets.only(top: 20 * fem, bottom: 10 * fem),
                                child: TabBar(
                                    tabs: [
                                      myService(context, 0, "Transfert", "assets/images/envoi_icon.svg"),
                                      myService(context, 1, "Payement", "assets/images/paiement_tfs.svg"),
                                      myService(context, 2, "Crédit", "assets/images/achat.png",),
                                      myService(context, 3, "Factures", "assets/images/secteurs.png"),
                                    ],
                                    controller: tabController,
                                    labelStyle: TextStyle(fontSize: 10 * fem, fontWeight: FontWeight.bold),
                                    unselectedLabelStyle: TextStyle(fontSize: 10 * fem),
                                    labelColor: textPrimaryColor,
                                    unselectedLabelColor: textPrimaryColor.withOpacity(0.8),
                                    isScrollable: false,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorColor: transparentColor,
                                    dividerColor: transparentColor),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                  child: GestureDetector(
                    onTap: ()
{
                      // Ferme le clavier si on tape ailleurs
                      FocusScope.of(context).unfocus();
                    },
                    child: _widgetOptions.elementAt(_selectedTab ?? widget.selectedTab),
                  ),
                )

              ],
            ),
          ),
        ));
  }

  myService(BuildContext context, int index, String name, String img)
{
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _onItemTapped(index),
          child: Container(
            width: 48 * fem,
            height: 48 * fem,
            decoration: BoxDecoration(
              color: _selectedTab == index ? homeTab : whiteColor,
              shape: BoxShape.circle,
              border: _selectedTab == index ? Border.all(
                color: const Color(0xFF646FEF), // couleur #646FEF
                width: 2, // fine bordure
              ) : null,
            ),
            padding: EdgeInsets.all(11 * fem),
            child: (img.contains(".png")) ?
            Image.asset(
              package: 'micro_commons',
              img,
              height: 20 * ffem,
              width: 20 * ffem,
              fit: BoxFit.contain,
            ) : SvgPicture.asset(
              package: 'micro_commons',
              img,
              height: 20 * ffem,
              width: 20 * ffem,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 10 * fem,
              fontWeight: _selectedTab == index ? FontWeight.bold : FontWeight.w400,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

