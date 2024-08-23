import 'dart:math';

import 'package:flutter/material.dart';
import 'package:la_ruleta/constants/colors.dart';
import 'package:la_ruleta/database/player_db.dart';
import 'package:la_ruleta/constants/strings.dart';
import 'package:la_ruleta/model/player.dart';
import 'package:la_ruleta/widgets/ruleta_text_button.dart';
import 'package:la_ruleta/widgets/fortune_wheel.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({Key? key}) : super(key: key);

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late List<WheelItem> wheelItems;

  Future<List<Player>>? _playerList;
  final playerDB = PlayerDB();

  void fetchPlayers() {
    setState(() {
      _playerList = playerDB.fetchAll();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPlayers();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.addListener(() {
      setState(() {});
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Result of spin
      }
    });
  }

  void spinWheel() {
    animation = Tween(begin: 0.0, end: 2 * pi).animate(animation);
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColorYellow,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 250,
                    child: FutureBuilder(
                      future: _playerList,
                      builder: (context, snapshot) {
                        print("building future");
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final players = snapshot.data!;
                          wheelItems = fetchWheelItems(players);
                          return FortuneWheel(
                            items: wheelItems,
                            size: 300,
                            radius: 170,
                            outlineColor: kColorBlack,
                            outlineStroke: 7,
                            divisionColor: kColorSnowWhite,
                            divisionStroke: 5,
                            controller: controller,
                            animation: animation,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: RuletaTextButton(
                  width: 200,
                  text: Strings.girar,
                  onTap: () {
                    print("try spin");
                    spinWheel();
                  },
                  color: kColorRed,
                  textStyle: const TextStyle(
                      fontFamily: 'LuckiestGuy',
                      fontSize: 40,
                      color: kColorSnowWhite,
                      height: 2),
                ),
              )
            ],
          ),
        ));
  }

  List<WheelItem> fetchWheelItems(List<Player> players) {
    List<WheelItem> items = [];
    var rng = Random();
    int lastColorIndex = 0;
    int colorIndex = 0;
    print("why");
    for (int i = 0; i < players.length; i++) {
      colorIndex = rng.nextInt(kRoulettePalette.length);
      if (colorIndex == lastColorIndex) {
        colorIndex = (colorIndex + 1) % kRoulettePalette.length;
      }

      items.add(WheelItem(players[i].name, kRoulettePalette[colorIndex]));
      lastColorIndex = colorIndex;
    }
    return items;
  }
}
