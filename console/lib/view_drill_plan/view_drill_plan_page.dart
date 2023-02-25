import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/plan_drill/pd_app_bar.dart';
import '../components/plan_drill/pd_progress_bar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../models/drill_plan.dart';
import '../nav/nav.dart';
import '../screen_too_small/show_notice_on_small.dart';
import 'view_drill_plan_view.dart';

class ViewDrillPlanPage extends StatefulWidget {
  const ViewDrillPlanPage({super.key, this.params});

  final FFParameters? params;

  @override
  State<ViewDrillPlanPage> createState() => _ViewDrillPlanPageState();
}

class _ViewDrillPlanPageState extends State<ViewDrillPlanPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  bool _loading = true;

  void setLoading([bool? value]) =>
      setState(() => _loading = value ?? !_loading);

  String? drillID;
  DrillPlan? drillPlan;

  void getDrillPlan() async {
    final tmp = await DrillPlan.fromDrillID(drillID!);
    if (tmp != null && mounted) {
      setState(() => drillPlan = tmp);
      setLoading(false);
    }
  }

  Future<void> refreshDrillPlan() async {
    if (drillID != null) {
      setLoading(true);
      final tmp = await DrillPlan.fromDrillID(drillID!);
      if (tmp != null && mounted) {
        setState(() => drillPlan = tmp);
        setLoading(false);
      }
    }
  }

  double progress = 0.92;

  @override
  void initState() {
    super.initState();
    drillID = widget.params?.getParam('drillID', ParamType.String);
    // ignore: avoid_print
    print('drillID: $drillID');
    if (drillID != null) getDrillPlan();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PDAppBar(
                      planning: false,
                      creator: (drillPlan != null &&
                          _auth.currentUser!.uid == drillPlan!.creatorID),
                      drillPlan: drillPlan,
                      refreshDrillPlan: refreshDrillPlan,
                    ),
                    PDProgressBar(progress),
                    Expanded(
                      child: (!_loading && drillPlan != null)
                          ? Padding(
                              padding: const EdgeInsets.all(24),
                              child: VDPView(
                                drillPlan!,
                                _auth.currentUser!.uid == drillPlan!.creatorID,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator.adaptive()),
                    )
                  ],
                ),
                // // plan drill BottomNavButtons
                // if (pdController != null)
                //   PDBottomNavButtons(pdController: pdController!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
