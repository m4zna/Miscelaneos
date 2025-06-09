import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem({required this.title, required this.icon, required this.route});
}

final List<MenuItem> menuItems = [
  MenuItem(title: 'Giroscopio', icon: Icons.downloading, route: '/gyroscope'),
  MenuItem(title: 'Acelerometro', icon: Icons.speed, route: '/accelerometer'),
  MenuItem(title: 'Magnetrometro', icon: Icons.explore_outlined, route: '/magnetometer'),
  MenuItem(
      title: 'Giroscopio Ball', icon: Icons.sports_baseball_outlined, route: '/gyroscope-ball'),
  MenuItem(title: 'Brujula', icon: Icons.explore, route: '/compass'),
  MenuItem(title: 'Pokemons', icon: Icons.catching_pokemon_outlined, route: '/pokemons'),
  MenuItem(title: 'Biómetricos', icon: Icons.fingerprint_outlined, route: '/biometrics'),

  MenuItem(title: 'Ubicación', icon: Icons.location_on_outlined, route: '/location'),
  MenuItem(title: 'Mapa', icon: Icons.map_outlined, route: '/maps'),
  MenuItem(title: 'Control', icon: Icons.control_camera_outlined, route: '/control'),

  MenuItem(title: 'Badge', icon: Icons.notification_important_rounded, route: '/badge'),

  MenuItem(title: 'Anuncio Completo', icon: Icons.ad_units_rounded, route: '/ad-full'),
  MenuItem(title: 'Anuncio Recompensa', icon: Icons.fort, route: '/ad-rewarded'),

];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: menuItems
            .map((item) => HomeMenuItem(title: item.title, icon: item.icon, route: item.route))
            .toList());
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.route,
      this.bgColors = const [Colors.lightBlue, Colors.blue]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: bgColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
