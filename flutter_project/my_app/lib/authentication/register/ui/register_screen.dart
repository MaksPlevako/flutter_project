import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/authentication/authentication_services/authentication_services.dart';
import 'package:my_app/profile/models/user_model.dart';
import 'package:my_app/profile/services/user_services.dart';
import 'package:my_app/routing/app_routing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/user_data/user_data.dart';
import '../../../profile/services/fire_and_ice_services.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final AuthenticationService _auth = AuthenticationService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        label: const Text('Name'),
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
                    const SizedBox(
                      height: 16,
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => _register(context, ref),
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(500.0, 50.0)),
                        backgroundColor: WidgetStatePropertyAll(Colors.orange),
                      ),
                      child: const Text(
                        'Sing Up',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () =>
                              context.goNamed(NavRoutes.login.name),
                          child: Text(
                            'Login',
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

  void _register(BuildContext context, WidgetRef ref) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      // Регистрация пользователя через Firebase
      User? user = await _auth.singUpWithEmailAndPassword(email, password);

      if (user != null) {
        // Инициализация сервиса для работы с БД
        final UserService _userService = UserService();

        // Проверяем, существует ли пользователь в базе
        UserModel? existingUser = await _userService.getUserByEmail(email);

        if (existingUser == null) {
          // Если пользователя нет, создаём нового
          final UserModel newUser = UserModel(
            id: user.uid,
            name: username,
            email: email,
          );
          await _userService.createUser(newUser);
        } else {
          print('User already exists in the database');
        }

        // Получаем пользователя из базы
        UserModel? fetchedUser = await _userService.getUserByEmail(email);

        if (fetchedUser != null) {
          // Обновляем состояние пользователя через ref
          ref.read(userProvider.notifier).updateUser(
                name: fetchedUser.name,
                email: fetchedUser.email,
                userImg: fetchedUser.img,
              );
          FireAndIceServices _fireAndIceServices = FireAndIceServices();
          await _fireAndIceServices.createStreak();
          // Переход на главную страницу
          context.goNamed(NavRoutes.list.name);
        } else {
          print('Failed to fetch user from the database');
        }
      } else {
        print('Registration failed');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }
}
