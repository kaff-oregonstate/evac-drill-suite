import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class CheckSpamDialog extends StatelessWidget {
  const CheckSpamDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: FFTheme.of(context).secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: SizedBox(
          width: 500 - 24 * 2,
          height: 360,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Access requested.',
                style: FFTheme.of(context).title1,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                child: Text(
                  'If approved, we will email you a sign-in link.',
                  style: FFTheme.of(context).subtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              48, 0, 48, 0),
                          child: Text(
                            'that email might go to spam, so add: ',
                            style: FFTheme.of(context).bodyText1,
                          ),
                        ),
                        SelectionArea(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 4, 12, 6),
                            child: Text(
                              'no-reply@evac-drill-console.firebaseapp.com',
                              style: FFTheme.of(context).bodyText2.override(
                                    fontFamily: 'Space Grotesk',
                                    color: const Color(0xFFD64C06),
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              48, 0, 48, 0),
                          child: Text(
                            'to your contacts, and check your spam!',
                            style: FFTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(48, 24, 48, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'OK',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FFTheme.of(context).primaryColor,
                        textStyle: FFTheme.of(context).subtitle2.override(
                              fontFamily: 'Space Grotesk',
                              color: FFTheme.of(context).primaryBtnText,
                            ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'stuck? shoot me an email: ',
                    style: FFTheme.of(context).bodyText2,
                  ),
                  SelectionArea(
                    child: Text(
                      'david@davidkaff.io',
                      style: FFTheme.of(context).bodyText2.override(
                            fontFamily: 'Space Grotesk',
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
