import 'package:evac_drill_console/backend/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_util.dart';

const deploymentUrl =
    'https://practice-evac-drill-console-3.wm.r.appspot.com/signin/#/';
// URL must be whitelisted in the Firebase Console.
final acs = ActionCodeSettings(url: deploymentUrl, handleCodeInApp: true);

Future requestEmailLink(
  BuildContext context,
  String email,
) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );
  // check if user is in system
  final signInMethods = await _auth.fetchSignInMethodsForEmail(email);

  if (signInMethods.contains('emailLink')) {
    // send the link to email
    await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: acs);
  } else {
    // add a RequestedAccess document to Firestore for email
    maybeCreateRequestedAccess(email);
  }
}

Future<User?> signInWithEmailLink(
    BuildContext context, String email, String emailLink) async {
  signInFunc() => FirebaseAuth.instanceFor(
        app: Firebase.app(),
        persistence: Persistence.INDEXED_DB,
      ).signInWithEmailLink(email: email.trim(), emailLink: emailLink);
  return signInOrCreateAccount(context, signInFunc, 'EMAIL_LINK');
}
