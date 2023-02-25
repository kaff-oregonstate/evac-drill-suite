import 'package:evac_drill_cryptography/src/decrypt_results/decrypt_results_view.dart';
import 'package:flutter/material.dart';

import 'add_key/add_key_view.dart';
import 'main_menu_view.dart';
import 'keys/keys_controller.dart';
import 'gen_key/gen_key_view.dart';
import 'screen_too_small/show_notice_on_small.dart';
import 'view_keys/view_keys_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.keysController,
  });

  final KeysController keysController;

  @override
  Widget build(BuildContext context) {
    // Glue the GenKeysController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the GenKeysController for changes.
    // Whenever the user updates their genKeys, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: keysController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                late Widget page;
                switch (routeSettings.name) {
                  case DecryptResultsView.routeName:
                    page = DecryptResultsView(controller: keysController);
                    break;
                  case ViewKeysView.routeName:
                    page = ViewKeysView(controller: keysController);
                    break;
                  case GenKeyView.routeName:
                    page = GenKeyView(controller: keysController);
                    break;
                  case AddKeyView.routeName:
                    page = AddKeyView(controller: keysController);
                    break;
                  // case SampleItemDetailsView.routeName:
                  //   return const SampleItemDetailsView();
                  case MainMenuView.routeName:
                  default:
                    page = const MainMenuView();
                }
                return ShowNoticeOnSmall(child: page);
              },
            );
          },
        );
      },
    );
  }
}
