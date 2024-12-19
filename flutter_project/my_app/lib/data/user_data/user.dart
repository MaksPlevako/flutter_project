import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String userName;
  final String userEmail;
  final String? userImg;

  UserState({required this.userName, required this.userEmail, this.userImg});
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier()
      : super(
          UserState(
              userName: 'Name',
              userEmail: '',
              userImg: 'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
        );
}

final fireProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    return UserNotifier();
  },
);
