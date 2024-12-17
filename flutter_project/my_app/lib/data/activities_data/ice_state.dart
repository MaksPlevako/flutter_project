import 'package:flutter_riverpod/flutter_riverpod.dart';

// Определим начальное состояние
class IceState {
  final int ice;
  IceState({required this.ice});
}

class IceNotifier extends StateNotifier<IceState> {
  IceNotifier() : super(IceState(ice: 20));

  // Функция для увеличения ice
  void incrementIce() {
    state = IceState(ice: state.ice + 1);
  }

  // Функция для уменьшения ice
  void decrementIce() {
    state = IceState(ice: state.ice - 1);
  }
}

// Провайдер для управления состоянием
final iceProvider = StateNotifierProvider<IceNotifier, IceState>((ref) {
  return IceNotifier();
});
