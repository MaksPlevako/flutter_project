import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/routing/app_routing.dart';

class OurBottomNavBar extends StatelessWidget {
  const OurBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем текущий путь
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    int _getSelectedIndex(String location) {
      switch (location) {
        case '/list':
          return 0;
        case '/actions':
          return 1;
        case '/chart':
          return 2;
        case '/block':
          return 3;
        case '/people':
          return 4;
        default:
          return 0;
      }
    }

    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(currentLocation),
      onTap: (index) {
        switch (index) {
          case 0:
            context.goNamed(NavRoutes.list.name);
            break;
          case 1:
            context.goNamed(NavRoutes.actions.name);
            break;
          case 2:
            context.goNamed(NavRoutes.chart.name);
            break;
          case 3:
            context.goNamed(NavRoutes.block.name);
            break;
          case 4:
            context.goNamed(NavRoutes.people.name);
            break;
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: _buildCustomIcon(
            icon: Icons.list,
            isSelected: _getSelectedIndex(currentLocation) == 0,
          ),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: _buildCustomIcon(
            icon: Icons.article_outlined,
            isSelected: _getSelectedIndex(currentLocation) == 1,
          ),
          label: 'Article',
        ),
        BottomNavigationBarItem(
          icon: _buildCustomIcon(
            icon: Icons.bar_chart,
            isSelected: _getSelectedIndex(currentLocation) == 2,
          ),
          label: 'Chart',
        ),
        BottomNavigationBarItem(
          icon: _buildCustomIcon(
            icon: Icons.block,
            isSelected: _getSelectedIndex(currentLocation) == 3,
          ),
          label: 'Block',
        ),
        BottomNavigationBarItem(
          icon: _buildCustomIcon(
            icon: Icons.people_alt_outlined,
            isSelected: _getSelectedIndex(currentLocation) == 4,
          ),
          label: 'People',
        ),
      ],
    );
  }
}

// Метод для кастомной иконки с фоном и обводкой

Widget _buildCustomIcon({required IconData icon, required bool isSelected}) {
  return Container(
    decoration: BoxDecoration(
      color: isSelected ? Colors.grey[300] : Colors.transparent, // Цвет фона
      borderRadius: BorderRadius.circular(12), // Скругление углов
      border: Border.all(
        color: isSelected ? Colors.white : Colors.transparent, // Цвет обводки
        width: 1, // Толщина обводки
      ),
    ),
    padding: const EdgeInsets.all(12), // Отступы внутри контейнера
    child: Icon(
      icon,
      size: 30, // Установите размер иконки
      color: isSelected ? Colors.black : Colors.grey, // Цвет иконки
    ),
  );
}
