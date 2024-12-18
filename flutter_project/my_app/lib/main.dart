import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/routing/app_routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Основной метод для запуска приложения
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: UNFCK(),
    ),
  );
}

class UNFCK extends StatelessWidget {
  const UNFCK({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routerConfig: appRouter,
    );
  }
}
