import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/material.dart';

import '../../models/drill_plan.dart';
import 'view_drill_plan_json_view.dart';

class ViewDrillPlanJsonPage extends StatefulWidget {
  const ViewDrillPlanJsonPage({super.key, this.params});

  final FFParameters? params;

  @override
  State<ViewDrillPlanJsonPage> createState() => _ViewDrillPlanJsonPageState();
}

class _ViewDrillPlanJsonPageState extends State<ViewDrillPlanJsonPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = true;
  String? drillID;
  DrillPlan? drillPlan;

  @override
  void initState() {
    super.initState();
    drillID = widget.params?.getParam('drillID', ParamType.String);
    // ignore: avoid_print
    print('drillID: $drillID');
    if (drillID != null) getDrillPlan();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void getDrillPlan() async {
    final tmp = await DrillPlan.fromDrillID(drillID!);
    setState(() {
      drillPlan = tmp;
    });
    setIsLoading();
  }

  void setIsLoading() {
    setState(() {
      loading = !loading;
    });
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: (loading)
                      ? [
                          const CircularProgressIndicator.adaptive(),
                        ]
                      : (drillPlan == null)
                          ? [Text('Drill with ID `$drillID` not found')]
                          : [ViewDrillPlanJsonView(drillPlan!)],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 300,
                    child: DefaultFFButton('go back', () => context.pop()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
