import 'package:base_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ??= FirebaseService._();
  FirebaseService._();

  bool _isInitialized = false;

  late final AuthService _auth;
  late final FirestoreService _firestore;

  Future<void> init() async {
    if (_isInitialized) return;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _auth = AuthService();
    _firestore = FirestoreService();
    _isInitialized = true;
  }

  AuthService get auth {
    if (!_isInitialized) throw StateError('FirebaseService not initialized');
    return _auth;
  }

  FirestoreService get firestore {
    if (!_isInitialized) throw StateError('FirebaseService not initialized');
    return _firestore;
  }
}

// AUTH : gère login/users
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance Firebase Auth
  String? _verificationId;
  // Retourne user connecté actuel (null si déconnecté)
  User? get currentUser => _auth.currentUser;

  // Écoute changements statut auth (connecté/déconnecté) → Stream pour UI réactive
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> sendOtp(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone, // Format international
      verificationCompleted: (PhoneAuthCredential cred) {
        // Auto-verify Android (rare)
        _auth.signInWithCredential(cred);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e; // Ex. numéro invalide
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId; // ← Stocké pour verify
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  // Étape 2 : Vérif OTP saisi → Connecte Firebase Auth
  Future<User?> verifyOtp(String otpCode) async {
    if (_verificationId == null) throw Exception('OTP non envoyé');

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otpCode, // 6 chiffres saisi
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user; // User Firebase connecté (phone verified)
  }

  // Déconnexion → Vide currentUser
  Future<void> signOut() async => await _auth.signOut();
}

// FIRESTORE : gère DB
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Instance DB

  // Retourne collection 'users' (référence pour query/écritures)
  CollectionReference<Map<String, dynamic>> users() => _db.collection('users');

  // Sauvegarde/met à jour user (fusionne si existe) → Vide (fire-and-forget)
  Future<void> saveUser(String id, Map<String, dynamic> data) async {
    await users().doc(id).set(data); // doc(id) = user par ID
  }

  // Récupère 1 user par ID → Future<DocumentSnapshot?>
  Future<DocumentSnapshot?> getUser(String id) async =>
      await users().doc(id).get();

  // Écoute user en temps réel → Stream pour UI live
  Stream<DocumentSnapshot> streamUser(String id) => users().doc(id).snapshots();
}
