import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evac_drill_console/dialogs/check_spam_dialog.dart';
import 'package:evac_drill_console/nav/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// FIXME: old url
const deploymentUrl = 'https://practice-evac-drill-console.firebaseapp.com/';
// 'https://practice-evac-drill-console-3.wm.r.appspot.com/';

// HACK: this file is holding waaaay too much info. split into new (see below)

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, this.params});

  final FFParameters? params;

  @override
  Widget build(BuildContext context) {
    // both of these work:
    // print(params?.state.queryParams.toString());
    // print(Uri.base);
    final link = Uri.base;
    return Scaffold(
      body: Center(child: AuthGate(params: params, link: link)),
    );
  }
}

// HACK: Move f'n'ty of ManageTeamDemo to ManageTeam, WebNavBar
class ManageTeamDemo extends StatelessWidget {
  const ManageTeamDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Current User:',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_auth.currentUser?.email ?? 'error'),
              Text(
                  'email verified: ${_auth.currentUser?.emailVerified.toString() ?? 'error'}'),
              TextButton(
                  onPressed: () {
                    _auth.signOut();
                  },
                  child: const Text('Sign out')),
            ],
          ),
        ),
        // Text(_auth.currentUser?.displayName ?? 'error'),
        const SizedBox(height: 120),
        Text(
          'Users requesting access:',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('RequestedAccess')
              .snapshots(),
          builder: ((
            context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                final docData = document.data()! as Map<String, dynamic>;
                return SizedBox(
                  width: 400,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(docData['email']),
                        Row(
                          // two buttons: approve and deny
                          children: [
                            Material(
                              child: InkWell(
                                onTap: () async {
                                  // deny deletes the firestore document
                                  await FirebaseFirestore.instance
                                      .collection('RequestedAccess')
                                      .doc(document.id)
                                      .delete();
                                  // then snackbar notify
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Refused access to ${docData['email']}')));
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Material(
                              child: InkWell(
                                onTap: () async {
                                  bool error = false;
                                  // approve sends an invite email
                                  var acs = ActionCodeSettings(
                                    // URL must be whitelisted in the Firebase Console.
                                    url: deploymentUrl,
                                    handleCodeInApp: true,
                                  );
                                  await _auth
                                      .sendSignInLinkToEmail(
                                    email: docData['email'],
                                    actionCodeSettings: acs,
                                  )
                                      .catchError((e) {
                                    error = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error sending sign-in email ${e.message ?? e ?? ''}')));
                                  }).then((value) {
                                    if (!error) {
                                      // then deletes doc
                                      FirebaseFirestore.instance
                                          .collection('RequestedAccess')
                                          .doc(document.id)
                                          .delete()
                                          // then snackbar notify
                                          .then((value) => ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Sending sign-in email to ${docData['email']}'))));
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.mail_outline_rounded,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ),

        const SizedBox(height: 20),
      ],
    ));
  }
}

enum AuthMode { requestLink, signIn }

extension on AuthMode {
  String get label =>
      this == AuthMode.requestLink ? 'Request Sign-in Link' : 'Sign-in';
}

/// Entrypoint example for sign-in flow with Firebase
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key, this.params, required this.link}) : super(key: key);

  final FFParameters? params;
  final Uri link;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  AuthMode mode = AuthMode.requestLink;

  String log = '';

  String error = '';
  bool isLoading = false;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void setEmailFromHive() async {
    var userPrefsBox = await Hive.openBox('userPrefs');
    final String? lastUsedEmail = userPrefsBox.get('lastUsedEmail');
    if (lastUsedEmail != null) {
      emailController.value = TextEditingValue(text: lastUsedEmail);
    }
  }

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.isSignInWithEmailLink(Uri.base.toString())) {
      setState(() {
        mode = AuthMode.signIn;
      });
    }
    setEmailFromHive();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mode == AuthMode.signIn) {}
    return AuthGateLayout(
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(log),
            Text(
              (mode == AuthMode.signIn)
                  ? 'Just to confirm, what email are you signing in with?'
                  : 'To sign-in to the Evacuation Drill Console, please enter your email:',
              style: null,
            ),
            const SizedBox(height: 20),
            // error banner
            Visibility(
                visible: error.isNotEmpty,
                child: MaterialBanner(
                  backgroundColor: Theme.of(context).errorColor,
                  content: Text(error),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            error = '';
                          });
                        },
                        child: const Text(
                          'dismiss',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                  contentTextStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.all(10),
                )),
            const SizedBox(height: 20),
            // email input
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
              // initialValue:
              //     (_sp != null) ? _sp!.getString('lastUsedEmail') : null,
              validator: (value) =>
                  // add email format validation
                  (value != null && value.isNotEmpty) ? null : 'Required',
            ),
            const SizedBox(height: 20),
            // submit button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async => _handleAuthException(_emailLink),
                child: isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : Text(mode.label),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _emailLink() async {
    if (formKey.currentState?.validate() ?? false) {
      if (mode == AuthMode.signIn) {
        // const consoleSnippet = 'console/#/';
        // const signinSnippet = 'signin/#/';
        // final authLink = _link.toString().replaceFirst(signinSnippet, '');
        if (widget.link.toString().contains('localhost')) {
          var newLink = widget.link.toString().replaceFirst(
              'http://localhost:50181',
              'https://practice-evac-drill-console.web.app/plannedDrills');
          await _auth.signInWithEmailLink(
            email: emailController.text,
            emailLink: newLink,
          );
        } else {
          await _auth.signInWithEmailLink(
            email: emailController.text,
            emailLink: widget.link.toString(),
          );
        }
      } else if (mode == AuthMode.requestLink) {
        // check if user is in system
        final signInMethods =
            await _auth.fetchSignInMethodsForEmail(emailController.text);

        if (signInMethods.contains('emailLink')) {
          // send sign-in link
          var acs = ActionCodeSettings(
            // URL must be whitelisted in the Firebase Console.
            url: deploymentUrl,
            // url: 'http://localhost:8080/console/#/',
            handleCodeInApp: true,
          );
          await _auth
              .sendSignInLinkToEmail(
                email: emailController.text,
                actionCodeSettings: acs,
              )
              .then((value) => showAccessRequestDialog(context));
        } else {
          // add email to requested access Firebase collection
          // TODO: add Firebase document for access request
          await FirebaseFirestore.instance
              .collection('RequestedAccess')
              .add({'email': emailController.text}).then(
                  (value) => showAccessRequestDialog(context));
        }

        // save the email to Hive userPrefs box
        var userPrefsBox = Hive.box('userPrefs');
        userPrefsBox.put('lastUsedEmail', emailController.text);
      }
    }
  }

  Future<void> _handleAuthException(
      Future<void> Function() authFunction) async {
    setIsLoading();
    try {
      await authFunction();
    } on FirebaseAuthException catch (e) {
      // log += 'FirebaseAuthException e: ${e.toString()}' + '\n';
      setState(() {
        error = '${e.message}';
      });
    } catch (e) {
      // log += 'regular e: ${e.toString()}' + '\n';
      setState(() {
        error = '$e';
      });
    } finally {
      setIsLoading();
    }
  }

  void showAccessRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const CheckSpamDialog(),
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Successfully sent email verification')));
  }
}

class AuthGateLayout extends StatelessWidget {
  const AuthGateLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SafeArea(
                    child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: child,
                )))));
  }
}
