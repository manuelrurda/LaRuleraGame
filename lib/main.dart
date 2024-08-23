import 'package:flutter/material.dart';
import 'package:la_ruleta/screens/menu_screen.dart';
import 'package:la_ruleta/screens/player_selection.dart';
import 'package:la_ruleta/screens/roulette_screen.dart';

void main() => runApp(LaRuleta());

class LaRuleta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/player_selection': (context) => const PlayerSelectionScreen(),
        '/roulette': (context) => const RouletteScreen()
      },
    );
  }
}
