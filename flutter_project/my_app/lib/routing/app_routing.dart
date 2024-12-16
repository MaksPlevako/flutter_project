import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/list/ui/list_screen.dart';
import 'package:my_app/settings/ui/settings_screen.dart';

enum NavRoutes {
  main('main', '/'),
  settings('settings', '/settings'),
  list('list', '/list'),
  actions('actions', '/actions'),
  chart('chart', '/chart'),
  block('block', '/block'),
  people('people', '/people');

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
        return const ListScreen(title: 'Home Page');
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
