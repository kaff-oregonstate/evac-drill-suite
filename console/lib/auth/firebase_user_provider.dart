import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rxdart/rxdart.dart';

class FfEvacDrillConsoleProtoFirebaseUser {
  FfEvacDrillConsoleProtoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FfEvacDrillConsoleProtoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FfEvacDrillConsoleProtoFirebaseUser>
    ffEvacDrillConsoleProtoFirebaseUserStream() => FirebaseAuth.instanceFor(
          app: Firebase.app(),
          persistence: Persistence.INDEXED_DB,
        )
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
