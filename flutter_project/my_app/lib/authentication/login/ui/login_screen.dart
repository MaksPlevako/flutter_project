import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/user_data/user_data.dart';
import '../../../profile/models/user_model.dart';
import '../../../profile/services/user_services.dart';
import '../../../routing/app_routing.dart';
import '../../authentication_services/authentication_services.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final AuthenticationService _auth = AuthenticationService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Sing Up",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: size.width * 0.8,
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade50,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.orange.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade50,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.orange.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _login(context, ref),
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(500.0, 50.0)),
                        backgroundColor: WidgetStatePropertyAll(Colors.orange),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don`t have an account?'),
                        TextButton(
                          onPressed: () =>
                              context.goNamed(NavRoutes.register.name),
                          child: Text(
                            'Sing up',
                            style: TextStyle(color: Colors.blue.shade500),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context, WidgetRef ref) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.singInWithEmailAndPassword(email, password);

    if (user != null) {
      final UserService userService = UserService();
      // Запрос данных пользователя из базы данных
      UserModel? fetchedUser = await userService.getUserByEmail(email);

      if (fetchedUser != null) {
        // Обновляем состояние через UserNotifier
        final userNotifier = ref.read(userProvider.notifier);
        userNotifier.updateUser(
          name: fetchedUser.name,
          email: fetchedUser.email,
          userImg: fetchedUser.img,
        );
        context.goNamed(NavRoutes.list.name);
      } else {
        print('Failed to fetch user from the database');
      }
    } else {
      print('failed to connect');
    }
  }

}
