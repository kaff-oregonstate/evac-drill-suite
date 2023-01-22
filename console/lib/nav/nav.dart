import 'dart:async';

import 'package:evac_drill_console/auth/firebase_user_provider.dart';
import 'package:evac_drill_console/index.dart';
import 'package:evac_drill_console/nav/loading_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

import 'serialization_util.dart';

export 'package:go_router/go_router.dart';

export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  FfEvacDrillConsoleProtoFirebaseUser? initialUser;
  FfEvacDrillConsoleProtoFirebaseUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(FfEvacDrillConsoleProtoFirebaseUser newUser) {
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnAuthChange) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, params) =>
          (appStateNotifier.loggedIn) ? MainPlannedDrillsPage() : SignInPage(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, params) => (appStateNotifier.loggedIn)
              ? MainPlannedDrillsPage()
              : SignInPage(params: params),
          routes: [
            FFRoute(
              name: 'Main_plannedDrills',
              path: 'plannedDrills',
              requireAuth: true,
              builder: (context, params) => MainPlannedDrillsPage(),
            ),
            FFRoute(
              name: 'Main_publishedDrills',
              path: 'publishedDrills',
              requireAuth: true,
              builder: (context, params) => MainPublishedDrillsPage(),
            ),
            FFRoute(
              name: 'Main_completedDrills',
              path: 'completedDrills',
              requireAuth: true,
              builder: (context, params) => MainCompletedDrillsPage(),
            ),
            FFRoute(
              name: 'planDrill',
              path: 'planDrill',
              requireAuth: true,
              builder: (context, params) => PlanDrillPage(),
            ),
            // FFRoute(
            //   name: 'planDrill-Procedure',
            //   path: 'planDrill-Procedure',
            //   requireAuth: true,
            //   builder: (context, params) => PlanDrillProcedureWidget(),
            // ),
            // FFRoute(
            //   name: 'planDrill-Survey-1',
            //   path: 'planDrill-Survey-1',
            //   requireAuth: true,
            //   builder: (context, params) => PlanDrillSurveyWidget(0),
            // ),
            // FFRoute(
            //   name: 'planDrill-Survey-2',
            //   path: 'planDrill-Survey-2',
            //   requireAuth: true,
            //   builder: (context, params) => PlanDrillSurveyWidget(1),
            // ),
            // FFRoute(
            //   name: 'planDrill-Evacuation',
            //   path: 'planDrill-Evacuation',
            //   requireAuth: true,
            //   builder: (context, params) => PlanDrillEvacuationWidget(),
            // ),
            FFRoute(
              name: 'finalReview',
              path: 'finalReview',
              requireAuth: true,
              builder: (context, params) => FinalReviewPage(),
            ),
            FFRoute(
              name: 'Main_teamMembersPage',
              path: 'teamMembersPage',
              requireAuth: true,
              builder: (context, params) => MainTeamMembersPage(),
            ),
            // FFRoute(
            //   name: 'addTeamMembers',
            //   path: 'addTeamMembers',
            //   builder: (context, params) => AddTeamMembersWidget(),
            // ),
            // FFRoute(
            //   name: 'signIn',
            //   path: 'signIn',
            //   builder: (context, params) => SignInPage(params: params),
            // ),
            // FFRoute(
            //   name: 'createProfile',
            //   path: 'createProfile',
            //   builder: (context, params) => CreateProfileWidget(),
            // ),
            // FFRoute(
            //   name: 'createTask',
            //   path: 'createTask',
            //   builder: (context, params) => CreateTaskWidget(),
            // ),
            // FFRoute(
            //   name: 'Main_projectsWeb',
            //   path: 'mainProjectsWeb',
            //   builder: (context, params) => MainProjectsWebWidget(),
            // ),
            // FFRoute(
            //   name: 'createProject',
            //   path: 'createProject',
            //   builder: (context, params) => CreateProjectWidget(),
            // ),
            // FFRoute(
            //   name: 'searchMembers',
            //   path: 'searchMembers',
            //   builder: (context, params) => SearchMembersWidget(),
            // ),
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ).toRoute(appStateNotifier),
      ],
      urlPathStrategy: UrlPathStrategy.path,
      redirect: (state) {
        if (appStateNotifier.loggedIn) {
          if (state.queryParams.isNotEmpty) {
            // we got logged in on the sign in page
            // with the email link containing a bunch of query params
            // let's clear those params now that we are going to show the dashboard
            return '/';
          }
        }
        return null;
      },
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState =>
      (routerDelegate.refreshListenable as AppStateNotifier);
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void setRedirectLocationIfUnset(String location) =>
      (routerDelegate.refreshListenable as AppStateNotifier)
          .updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    String? collectionName,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList, collectionName);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            // return '/login';
            // return '/signIn';
            return '/';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              // ? Container(
              //     color: Colors.transparent,
              //     child: Image.asset(
              //       // SplashImage
              //       // LoadingImage
              //       // 'assets/images/app_Tracker@1x.png',
              //       'assets/images/ConsoleTitle@1x.png',
              //       fit: BoxFit.cover,
              //     ),
              //   )
              ? const LoadingBackground()
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
