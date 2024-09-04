import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/modules/auth/auth.repository.dart';
import 'package:make_friends_app/modules/user/user.entity.dart';
import 'package:make_friends_app/modules/user/user.repository.dart';

final userServiceProvider = Provider((ref) => UserService(ref));

class UserService {
  final Ref _ref;
  UserService(this._ref);

  Future<void> createUser(AppUser user) async {
    final uid = _ref.read(uidProvider);
    final currentUser = _ref.read(currentUserProvider).value;
    if (uid == null) return;
    if (currentUser != null) return;

    await _ref.read(userRepositoryProvider).setUser(uid, user);
  }
}
