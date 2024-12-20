import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_app/profile/services/fire_and_ice_services.dart';

import '../../profile/models/fire_and_ice_model.dart';

// Состояние FireState
class FireAndIceState {
  final int fire;
  final int ice;

  FireAndIceState({required this.fire, required this.ice});
}

class FireAndIceNotifier extends StateNotifier<FireAndIceState> {
  FireAndIceNotifier() : super(FireAndIceState(fire: 0, ice: 0));

  void setFireAndIceState() async {
    FireAndIceServices _fireAndIceServices = FireAndIceServices();

    final _fireAndIce = await _fireAndIceServices.getStreakByUser();

    if (_fireAndIce != null) {
      state = FireAndIceState(fire: _fireAndIce.fire, ice: _fireAndIce.ice);
      print(
          'FireAndIce state updated: Fire = ${_fireAndIce.fire}, Ice = ${_fireAndIce.ice}');
    } else {
      print('Failed to fetch FireAndIce data');
    }
  }

  void plusToFire(int num) async {
    print('change fire');
    print(state.fire);
    // Обновляем локальное состояние
    state = FireAndIceState(fire: state.fire + num, ice: state.ice);
    print('changed fire');
    print(state.fire);

    // Создаём объект службы
    FireAndIceServices _fireAndIceServices = FireAndIceServices();

    // Обновляем данные в базе данных
    try {
      await _fireAndIceServices.updateStreak(
        FireAndIceModel(
          fire: state.fire,
          ice: state.ice,
          userUID: FirebaseAuth.instance.currentUser!.uid,
        ),
      );
    } catch (e) {
      print('Error updating streak: $e');
    }
  }
}

final fireAndIceProvider =
    StateNotifierProvider<FireAndIceNotifier, FireAndIceState>(
  (ref) {
    return FireAndIceNotifier();
  },
);
