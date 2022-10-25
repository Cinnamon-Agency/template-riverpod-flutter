import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class defining [Auth] stucture
abstract class Auth<T> {
  /// The current logged in user. Returns `null` if no user is logged in.
  T? get currentUser;

  /// Authenticate with email and password
  Future<T> signInWithEmailAndPassword(String email, String password);

  /// Authenticate with phone number
  Future<T> signInWithPhoneNumber(PhoneAuthCredential credential);
}
