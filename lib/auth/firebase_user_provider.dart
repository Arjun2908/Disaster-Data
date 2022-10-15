import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class MainBaseFirebaseUser {
  MainBaseFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MainBaseFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MainBaseFirebaseUser> mainBaseFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MainBaseFirebaseUser>(
      (user) {
        currentUser = MainBaseFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
