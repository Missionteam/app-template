import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:make_friends_app/config/app_router.dart';
import 'package:make_friends_app/modules/user/user.entity.dart';

class AuthService {
  static String? fetchInitPathByAuthState(
      AsyncValue<User?> authState, AppUser? currentUser) {
    String initialRoute = AppPath.signUp;
    authState.whenData(
      (user) {
        if (user == null) {
          return initialRoute = AppPath.signUp;
        }
        if (currentUser == null) {
          return initialRoute = AppPath.register;
        }
        return initialRoute = AppPath.home;
      },
    );
    return initialRoute;
  }
}
