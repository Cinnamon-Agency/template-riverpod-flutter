// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'auth.dart';

/// The interactions with [FirebaseAuth] should only happen through this service.
class FirebaseAuthService extends Auth {
  FirebaseAuthService(this._auth);

  /// The current [FurebaseAuth] instnce.
  final FirebaseAuth _auth;

  @override
  User? get currentUser => _auth.currentUser;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    void Function(PhoneAuthCredential? user)? onVerificationCompleted,
    void Function(String verificationId, [int? resendToken])? onCodeSent,
    void Function(FirebaseAuthException e)? onVerificationFailed,
    int? forceResendingToken,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (authCredential) async {
        log('Got phone AuthCredential: $authCredential');

        onVerificationCompleted?.call(authCredential);
      },
      codeSent: (verificationId, [resendToken]) async {
        log(verificationId);

        onCodeSent?.call(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log('Timed out: $verificationId');

        onCodeSent?.call(verificationId);
      },
      verificationFailed: (e) {
        onVerificationFailed?.call(e);
      },
      forceResendingToken: forceResendingToken,
    );
  }

  @override
  Future<User?> signInWithPhoneNumber(PhoneAuthCredential credential) async {
    try {
      // Sign in with the created phone auth credentials.
      final cred = await _auth.signInWithCredential(credential);

      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user;
    } catch (exception) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  Future<UserCredential?> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
