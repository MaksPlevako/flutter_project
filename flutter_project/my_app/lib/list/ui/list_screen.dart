import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/common/ui/our_app_bar.dart';
import 'package:my_app/common/ui/our_bottom_nav_bar.dart';
import 'package:my_app/list/ui/morning_routine_list.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: OurAppBar(),
        body: Center(
          child: Column(
            children: [MorningRoutineList()],
          ),
        ),
        bottomNavigationBar: OurBottomNavBar(),
      ),
    );
  }
}
