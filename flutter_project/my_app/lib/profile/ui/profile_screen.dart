import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/common/ui/our_app_bar.dart';
import 'package:my_app/common/ui/our_bottom_nav_bar.dart';
import 'package:my_app/profile/ui/profile_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar(),
      body: ProfileWidget(),
      bottomNavigationBar: const OurBottomNavBar(),
    );
  }
}
