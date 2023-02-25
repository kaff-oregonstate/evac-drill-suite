import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/plan_drill/pd_app_bar.dart';
import '../components/plan_drill/pd_bottom_nav_buttons.dart';
import '../components/plan_drill/pd_progress_bar.dart';
import '../components/plan_drill/pd_steps_list.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../models/drill_plan.dart';
import '../nav/nav.dart';
import '../plan_drill/plan_drill_controller.dart';
import '../plan_drill/plan_drill_view.dart';
import '../screen_too_small/show_notice_on_small.dart';

class PlanDrillPage extends StatefulWidget {
  const PlanDrillPage({super.key, this.params});

  final FFParameters? params;

  @override
  State<PlanDrillPage> createState() => _PlanDrillPageState();
}

class _PlanDrillPageState extends State<PlanDrillPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  PDController? pdController;

  bool _loading = true;
  bool _notCreator = false;
  bool _alreadyPublished = false;

  void setLoading([bool? value]) =>
      setState(() => _loading = value ?? !_loading);

  String? drillID;
  DrillPlan? drillPlan;
  String? initialView;

  void getDrillPlan() async {
    final tmp = await DrillPlan.fromDrillID(drillID!);
    if (tmp != null && mounted) {
      if (_auth.currentUser!.uid != tmp.creatorID) {
        setState(() => _notCreator = true);
      } else if (tmp.published) {
        setState(() => _alreadyPublished = true);
      } else {
        setState(() => drillPlan = tmp);
        setState(() => pdController = PDController.init(tmp, initialView));
        pdController!.addListener(updateControllerState);
      }
      setLoading(false);
    }
  }

  List<int>? planningSteps;
  // TODO: calculate progress ratio dynamically based on number of PDViews
  double progress = 0.12;

  void updateControllerState() {
    // ignore: avoid_print
    print('listening');
    if (mounted) setState(() => '');
    // if (mounted) setState(() => pdController = pdController);
  }

  @override
  void initState() {
    super.initState();
    drillID = widget.params?.getParam('drillID', ParamType.String);
    initialView = widget.params?.getParam('planDrillView', ParamType.String);
    // ignore: avoid_print
    print('drillID: $drillID');
    if (drillID != null) getDrillPlan();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    if (pdController != null) {
      pdController!.removeListener(updateControllerState);
    }
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PDAppBar(planning: true, pdController: pdController),
                    PDProgressBar(progress),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Stack(
                        fit: StackFit.expand,
                        children: (_notCreator || _alreadyPublished)
                            ? (_notCreator)
                                ? [
                                    const Center(
                                        child: Text(
                                            'You did not create this drill,\nand therefore cannot plan it.\nPlease return to the dashboard.')),
                                  ]
                                : [
                                    const Center(
                                        child: Text(
                                            'This drill is already published,\nand therefore cannot be planned further.\nPlease return to the dashboard and depublish\nthe drill if changes need to be made.')),
                                  ]
                            : (!_loading && pdController != null)
                                ? [
                                    PDView(pdController),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: PDStepsList(pdController),
                                    ),
                                  ]
                                : [
                                    const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ],
                      ),
                    ),
                  ],
                ),
                // plan drill BottomNavButtons
                if (pdController != null)
                  PDBottomNavButtons(pdController: pdController!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
