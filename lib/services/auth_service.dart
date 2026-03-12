import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    }
  }

  static const String _isLoggedInKey = 'is_logged_in';

  // Save login status to local storage
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Check login status from local storage
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email
  Future<UserCredential?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(name);
        // Save to Firestore
        await _saveUserToFirestore(credential.user!, name);
      }
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email
  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      // Trigger Google Sign In flow
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Get auth details from request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final GoogleSignInClientAuthorization? authorization = await googleUser
          .authorizationClient
          .authorizationForScopes(['email']);

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCred = await _auth.signInWithCredential(credential);

      if (userCred.user != null &&
          userCred.additionalUserInfo?.isNewUser == true) {
        // Save new Google user to Firestore
        await _saveUserToFirestore(
          userCred.user!,
          userCred.user!.displayName ?? 'User',
        );
      }

      return userCred;
    } catch (e) {
      // In version 7.x, cancellation throws GoogleSignInException or similar.
      // E.g. GoogleSignInException(code: "canceled"). Return null gracefully.
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _ensureGoogleSignInInitialized();
    await _googleSignIn.signOut();
    await _auth.signOut();
    await setLoggedIn(false);
  }

  // Helper function to save user info to Firestore
  Future<void> _saveUserToFirestore(User user, String name) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': name,
      'created_at': FieldValue.serverTimestamp(),
      'photo_url': user.photoURL ?? '',
    }, SetOptions(merge: true));
  }
}
