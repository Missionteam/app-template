import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/lib/firebase.dart';

final firebaseAuthRepositoryProvider = Provider(
  (ref) => FirebaseAuthRepository(ref.read(firebaseAuthProvider)),
);

final authUserProvider = StreamProvider<User?>((ref) async* {
  yield* ref.watch(firebaseAuthRepositoryProvider).authStateChanges();
});

final uidProvider = Provider((ref) => ref.watch(authUserProvider).value?.uid);

class FirebaseAuthRepository {
  final FirebaseAuth _auth;
  FirebaseAuthRepository(this._auth);

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  void singUpWithMail(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void signInWithMail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
