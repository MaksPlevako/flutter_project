import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/activities_data/fire_and_ice_state.dart';
import 'package:my_app/routing/app_routing.dart';
import '../../data/user_data/user_data.dart';

class OurAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const OurAppBar({super.key});

  @override
  ConsumerState<OurAppBar> createState() => _OurAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _OurAppBar extends ConsumerState<OurAppBar> {
  @override
  void initState() {
    super.initState();

    ref.read(fireAndIceProvider.notifier).setFireAndIceState();
  }

  @override
  Widget build(BuildContext context) {
    final fireState = ref.watch(fireAndIceProvider);
    UserState userState = ref.read(userProvider);
    String userImage = userState.userImg ??
        'https://cdn-icons-png.flaticon.com/512/147/147144.png';

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.goNamed(NavRoutes.settings.name),
              icon: const Icon(Icons.settings, color: Colors.black),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 165, 81, 0.1),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          fireState.fire.toString(),
                          style: const TextStyle(
                            fontSize: 17, // Размер шрифта
                            color: Colors.orange, // Цвет текста
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(41, 128, 204, 0.1),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          fireState.ice.toString(),
                          style: const TextStyle(
                            fontSize: 17, // Размер шрифта
                            color: Colors.blue, // Цвет текста
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.goNamed(NavRoutes.profile.name),
              icon: ClipOval(
                child: Image.network(
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  userImage,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                        Icons.error); // Если изображение не загружается
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
