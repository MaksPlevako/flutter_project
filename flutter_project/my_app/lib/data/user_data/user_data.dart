import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String? id;
  final String name;
  final String email;
  final String? userImg;

  UserState({
    this.id,
    required this.name,
    required this.email,
    this.userImg,
  });
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier()
      : super(
    UserState(
      id: null,
      name: '',
      email: '',
      userImg: 'https://cdn-icons-png.flaticon.com/512/147/147144.png',
    ),
  );

  // Обновление данных пользователя
  void updateUser({
    String? id,
    required String name,
    required String email,
    String? userImg,
  }) {
    state = UserState(
      id: id ?? state.id,
      name: name,
      email: email,
      userImg: userImg ?? state.userImg,
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
      (ref) {
    return UserNotifier();
  },
);
