import 'package:firebase_auth/firebase_auth.dart';

/// Repository responsible for handling Firebase Authentication operations.
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Stream of [User] changes to listen to session status.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Retrieve the current logged-in user, if any.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Signs in the user using email and password.
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _determineAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  /// Registers a new user using email and password.
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _determineAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out. Please try again.');
    }
  }

  /// Maps Firebase Authentication error codes to user-friendly messages.
  Exception _determineAuthException(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is badly formatted.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
        break;
      case 'user-not-found':
      case 'invalid-credential':
        message = 'Incorrect email or password.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'email-already-in-use':
        message = 'An account already exists for this email address.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password sign-in is not enabled for this project.';
        break;
      case 'weak-password':
        message = 'The password is too weak. Use a stronger password.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your internet connection.';
        break;
      default:
        message = e.message ?? 'Authentication failed. Please try again.';
    }
    return Exception(message);
  }
}
