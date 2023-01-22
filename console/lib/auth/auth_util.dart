import 'dart:async';

import 'package:evac_drill_console/backend/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import 'firebase_user_provider.dart';

// export 'anonymous_auth.dart';
// export 'jwt_token_auth.dart';

/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
Future<User?> signInOrCreateAccount(
  BuildContext context,
  Future<UserCredential?> Function() signInFunc,
  String authProvider,
) async {
  try {
    final userCredential = await signInFunc();
    if (userCredential?.user != null) {
      await maybeCreateUser(userCredential!.user!);
    }
    return userCredential?.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message!}')),
    );
    return null;
  }
}

Future signOut() {
  return FirebaseAuth.instance.signOut();
}

Future deleteUser(BuildContext context) async {
  try {
    if (currentUser?.user == null) {
      // FIXME: error logging with print is bad
      // ignore: avoid_print
      print('Error: delete user attempted with no logged in user!');
      return;
    }
    await currentUser?.user?.delete();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Too long since most recent sign in. Sign in again before deleting your account.')),
      );
    }
  }
}

String get currentUserEmail =>
    currentUserDocument?.email ?? currentUser?.user?.email ?? '';

String get currentUserUid => currentUser?.user?.uid ?? '';

String get currentUserDisplayName =>
    currentUserDocument?.displayName ?? currentUser?.user?.displayName ?? '';

String get currentUserPhoto =>
    currentUserDocument?.photoUrl ?? currentUser?.user?.photoURL ?? '';

String get currentJwtToken => _currentJwtToken ?? '';

bool get currentUserEmailVerified {
  // Reloads the user when checking in order to get the most up to date
  // email verified status.
  if (currentUser?.user != null && !currentUser!.user!.emailVerified) {
    currentUser!.user!
        .reload()
        .then((_) => currentUser!.user = FirebaseAuth.instance.currentUser);
  }
  return currentUser?.user?.emailVerified ?? false;
}

/// Create a Stream that listens to the current user's JWT Token, since Firebase
/// generates a new token every hour.
String? _currentJwtToken;
final jwtTokenStream = FirebaseAuth.instance
    .idTokenChanges()
    .map((user) async => _currentJwtToken = await user?.getIdToken())
    .asBroadcastStream();

DocumentReference? get currentUserReference => currentUser?.user != null
    ? UsersRecord.collection.doc(currentUser!.user!.uid)
    : null;

UsersRecord? currentUserDocument;
final authenticatedUserStream = FirebaseAuth.instance
    .authStateChanges()
    .map<String>((user) => user?.uid ?? '')
    .switchMap(
      (uid) => uid.isEmpty
          ? Stream.value(null)
          : UsersRecord.getDocument(UsersRecord.collection.doc(uid))
              .handleError((_) {}),
    )
    .map((user) => currentUserDocument = user)
    .asBroadcastStream();

class AuthUserStreamWidget extends StatelessWidget {
  const AuthUserStreamWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: authenticatedUserStream,
        builder: (context, _) => child,
      );
}
