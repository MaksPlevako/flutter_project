import 'package:flutter_riverpod/flutter_riverpod.dart';

// Состояние FireState
class FireState {
  final int fire;

  FireState({required this.fire});
}

// StateNotifier для управления состоянием fire
class FireNotifier extends StateNotifier<FireState> {
  FireNotifier() : super(FireState(fire: 10)); // Начальное значение fire

  // Функция для увеличения fire
  void incrementFire() {
    state = FireState(fire: state.fire + 1);
  }

  // Функция для уменьшения fire
  void decrementFire() {
    state = FireState(fire: state.fire - 1);
  }
}

final fireProvider = StateNotifierProvider<FireNotifier, FireState>((ref) {
  return FireNotifier();
});
