import 'package:flutter/material.dart';

import 'add_key/add_key_view.dart';
import 'decrypt_results/decrypt_results_view.dart';
import 'gen_key/gen_key_view.dart';
import 'view_keys/view_keys_view.dart';

/// Presents user with app functions
class MainMenuView extends StatelessWidget {
  const MainMenuView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Evac. Drill Encryption Manager',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          const MMTile(
            DecryptResultsView.title,
            Icons.lock_open_rounded,
            DecryptResultsView.routeName,
            // '/decrypt',
            300,
            400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              MMTile(
                ViewKeysView.title,
                Icons.key_rounded,
                ViewKeysView.routeName,
                // '/viewKeys',
                300 / 3,
                400 / 3,
              ),
              MMTile(
                GenKeyView.title,
                Icons.add_rounded,
                GenKeyView.routeName,
                // '/genKey',
                300 / 3,
                400 / 3,
              ),
              MMTile(
                AddKeyView.title,
                Icons.file_open_rounded,
                AddKeyView.routeName,
                // '/addKey',
                300 / 3,
                400 / 3,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class MMTile extends StatelessWidget {
  const MMTile(
    this.title,
    this.icon,
    this.route,
    this.height,
    this.width, {
    super.key,
  });

  final String title;
  final IconData icon;
  final String route;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pushNamed(
            context,
            route,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: height * 8 / 15,
                ),
                Text(
                  title,
                  style: (height > 280)
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
