import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/common/ui/our_app_bar.dart';
import 'package:my_app/common/ui/our_bottom_nav_bar.dart';
import 'package:my_app/data/activities_data/fire.dart';
import 'package:my_app/data/activities_data/ice.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Отображаем значение fire
              const Text('Fire'),
              const SizedBox(width: 5),
              // Кнопка для увеличения fire
              IconButton(
                onPressed: () {
                  // Увеличиваем значение fire при нажатии
                  ref.read(fireProvider.notifier).incrementFire();
                },
                icon: const Icon(Icons.add),
              ),
              const SizedBox(width: 5),
              // Кнопка для уменьшения fire
              IconButton(
                onPressed: () {
                  // Уменьшаем значение fire при нажатии
                  ref.read(fireProvider.notifier).decrementFire();
                },
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Отображаем значение fire
              const Text('Ice'),
              const SizedBox(width: 5),
              // Кнопка для увеличения fire
              IconButton(
                onPressed: () {
                  // Увеличиваем значение fire при нажатии
                  ref.read(iceProvider.notifier).incrementIce();
                },
                icon: const Icon(Icons.add),
              ),
              const SizedBox(width: 5),
              // Кнопка для уменьшения fire
              IconButton(
                onPressed: () {
                  // Уменьшаем значение fire при нажатии
                  ref.read(iceProvider.notifier).decrementIce();
                },
                icon: const Icon(Icons.remove),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: const OurBottomNavBar(),
    );
  }
}
