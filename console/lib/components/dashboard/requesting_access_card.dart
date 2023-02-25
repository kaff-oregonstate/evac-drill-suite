import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class RequestingAccessCard extends StatelessWidget {
  RequestingAccessCard(
    index,
    this.docData,
    this.refreshReqAccesses, {
    super.key,
  }) : shaded = index % 2 == 0;

  final Map<String, dynamic> docData;
  final Function refreshReqAccesses;
  final bool shaded;

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  @override
  Widget build(BuildContext context) {
    void showSnackbar(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (shaded)
              ? FFTheme.of(context).primaryBackground
              : FFTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FFTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              docData['email'],
              style: FFTheme.of(context).subtitle1.override(
                    fontFamily: 'Outfit',
                    color: FFTheme.of(context).primaryText,
                  ),
            ),
            Row(
              // two buttons: approve and deny
              children: [
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    iconSize: 32,
                    tooltip: 'Deny user access to Console',
                    onPressed: () async {
                      // deny deletes the firestore document
                      await FirebaseFirestore.instance
                          .collection('RequestedAccess')
                          .doc(docData['docID'])
                          .delete();
                      // then snackbar notify
                      showSnackbar('Refused access to ${docData['email']}');
                      refreshReqAccesses();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.red.shade700,
                      // size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    iconSize: 32,
                    tooltip:
                        'Approve user access to Console,\nand send sign-in link to email',
                    onPressed: () async {
                      bool error = false;
                      // approve sends an invite email
                      var acs = ActionCodeSettings(
                        // URL must be whitelisted in the Firebase Console.
                        url: FFAppState.deploymentUrl,
                        handleCodeInApp: true,
                      );
                      await _auth
                          .sendSignInLinkToEmail(
                        email: docData['email'],
                        actionCodeSettings: acs,
                      )
                          .catchError((e) {
                        error = true;
                        showSnackbar(
                            'Error sending sign-in email ${e.message ?? e ?? ''}');
                      }).then((value) {
                        if (!error) {
                          // then deletes doc
                          FirebaseFirestore.instance
                              .collection('RequestedAccess')
                              .doc(docData['docID'])
                              .delete()
                              // then snackbar notify
                              .then((value) {
                            showSnackbar(
                                'Sending sign-in email to ${docData['email']}');
                            refreshReqAccesses();
                          });
                        }
                      });
                    },
                    icon: Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.green.shade700,
                      // size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
