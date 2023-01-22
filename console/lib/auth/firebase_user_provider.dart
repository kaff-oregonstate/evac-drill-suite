import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FfEvacDrillConsoleProtoFirebaseUser {
  FfEvacDrillConsoleProtoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FfEvacDrillConsoleProtoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FfEvacDrillConsoleProtoFirebaseUser>
    ffEvacDrillConsoleProtoFirebaseUserStream() => FirebaseAuth.instance
            .authStateChanges()
            .debounce((user) => user == null && !loggedIn
                ? TimerStream(true, const Duration(seconds: 1))
                : Stream.value(user))
            .map<FfEvacDrillConsoleProtoFirebaseUser>(
          (user) {
            currentUser = FfEvacDrillConsoleProtoFirebaseUser(user);
            return currentUser!;
          },
        );
