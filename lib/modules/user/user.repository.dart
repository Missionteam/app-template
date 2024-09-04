import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/constant/firebase_constant.dart';
import 'package:make_friends_app/lib/firebase.dart';
import 'package:make_friends_app/modules/auth/auth.repository.dart';
import 'package:make_friends_app/modules/user/user.entity.dart';

final userRepositoryProvider =
    Provider((ref) => UserRepository(ref.watch(firestoreProvider)));

final currentUserProvider = StreamProvider<AppUser?>((ref) async* {
  final uid = ref.watch(uidProvider);
  yield* await ref.watch(userRepositoryProvider).subscribeUser(uid);
});

class UserRepository {
  final FirebaseFirestore db;
  UserRepository(this.db);

  CollectionReference<AppUser> get reference =>
      db.collection(CollectionName.users).withConverter<AppUser>(
            fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Stream<AppUser?> subscribeUser(String? uid) async* {
    if (uid == null) yield null;
    final snapshots = await this.reference.doc(uid).snapshots();
    yield* snapshots.map((snapshot) => snapshot.data());
  }

  Future<void> setUser(String uid, AppUser user) async {
    await this.reference.doc(uid).set(user);
  }
}
