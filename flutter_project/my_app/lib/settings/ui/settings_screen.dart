import 'package:flutter/material.dart';
import 'package:my_app/common/ui/our_app_bar.dart';
import 'package:my_app/common/ui/our_bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  final String title;
  const SettingsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: OurAppBar(),
      body: Center(
        child: Text('Settings Page'),
      ),
      bottomNavigationBar: OurBottomNavBar(),
    );
  }
}
