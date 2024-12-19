import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/authentication/login/ui/login_screen.dart';
import 'package:my_app/authentication/register/ui/register_screen.dart';
import 'package:my_app/list/ui/list_screen.dart';
import 'package:my_app/list/ui/new_morning_routine.dart';
import 'package:my_app/settings/ui/settings_screen.dart';

enum NavRoutes {
  main('main', '/'),
  settings('settings', '/settings'),
  create_morning_routine('new_routine', '/new_routine'),
  list('list', '/list'),
  actions('actions', '/actions'),
  chart('chart', '/chart'),
  block('block', '/block'),
  people('people', '/people'),
  login('login', '/login'),
  register('register', '/register'),
  profile('profile', '/profile');

  final String name;
  final String path;

  const NavRoutes(this.name, this.path);
}

final GoRouter appRouter = GoRouter(
  initialLocation: NavRoutes.list.path,
  routes: <RouteBase>[
    GoRoute(
      name: NavRoutes.main.name,
      path: NavRoutes.main.path,
      redirect: (BuildContext context, GoRouterState state) =>
          NavRoutes.main.path,
    ),
    GoRoute(
      name: NavRoutes.list.name,
      path: NavRoutes.list.path,
      builder: (BuildContext context, GoRouterState state) {
        return const ListScreen();
      },
    ),
    GoRoute(
      name: NavRoutes.create_morning_routine.name,
      path: NavRoutes.create_morning_routine.path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          opaque: false,
          child: Material(
            color: Colors.transparent,
            child: NewMorningRoutine(listLength: state.extra as int),
          ),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      name: NavRoutes.login.name,
      path: NavRoutes.login.path,
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      name: NavRoutes.register.name,
      path: NavRoutes.register.path,
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
    ),
    GoRoute(
      name: NavRoutes.profile.name,
      path: NavRoutes.profile.path,
      builder: (BuildContext context, GoRouterState state) {
        return const ListScreen();
      },
    ),
    GoRoute(
      name: NavRoutes.actions.name,
      path: NavRoutes.actions.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen(title: 'Actions Page');
      },
    ),
    GoRoute(
      name: NavRoutes.chart.name,
      path: NavRoutes.chart.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen(title: 'Chart Page');
      },
    ),
    GoRoute(
      name: NavRoutes.block.name,
      path: NavRoutes.block.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen(title: 'Block Page');
      },
    ),
    GoRoute(
      name: NavRoutes.people.name,
      path: NavRoutes.people.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen(title: 'People Page');
      },
    ),
    GoRoute(
      name: NavRoutes.settings.name,
      path: NavRoutes.settings.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen(title: 'Settings Page');
      },
    ),
  ],
);
