import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Provider for [AuthRepository].
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// StreamProvider listening to Firebase Auth state changes.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// StateNotifier responsible for managing the asynchronous action state of the auth forms.
/// It uses [AsyncValue<void>] to communicate loading and error states to the UI.
class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository authRepository;

  AuthController({required this.authRepository})
      : super(const AsyncValue.data(null));

  /// Logs in the user with [email] and [password].
  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.signInWithEmailAndPassword(email, password);
    });
  }

  /// Creates a new account with [email] and [password].
  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.createUserWithEmailAndPassword(email, password);
    });
  }

  /// Logs out the current user.
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.signOut();
    });
  }
}

/// Provider for [AuthController] to manage login/signup submission states.
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});
