import 'package:flutter/material.dart';
import 'package:la_ruleta/constants/colors.dart';
import 'package:la_ruleta/constants/strings.dart';
import 'package:la_ruleta/widgets/fortune_wheel.dart';

import '../widgets/ruleta_text_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late List<WheelItem> wheelItems;

  @override
  void initState() {
    super.initState();
    wheelItems = [];
    for (int i = 0; i < kRoulettePalette.length; i++) {
      wheelItems.add(WheelItem('', kRoulettePalette[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColorYellow,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Stack(clipBehavior: Clip.none, children: <Widget>[
                    Positioned(
                      top: 10,
                      left: -50,
                      child: Transform.rotate(
                        angle: 100,
                        child: SizedBox(
                            width: 80, child: Image.asset('images/beer.png')),
                      ),
                    ),
                    Positioned(
                      top: -100,
                      left: 230,
                      child: Transform.rotate(
                        angle: -100,
                        child: SizedBox(
                            width: 50,
                            child: Image.asset('images/bacardi.png')),
                      ),
                    ),
                    Text(
                      Strings.appName,
                      style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 60,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 15
                          ..color = kColorBlack,
                      ),
                    ),
                    const Text(
                      Strings.appName,
                      style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 60,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  width: 250,
                  child: Center(
                    child: FortuneWheel(
                      items: wheelItems,
                      size: 300,
                      radius: 150,
                      outlineColor: Colors.black,
                      divisionColor: Colors.white,
                      divisionStroke: 7,
                      outlineStroke: 7,
                    ),
                  ),
                  // child: Stack(
                  //   children: <Widget>[
                  //     CustomPaint(
                  //       painter: RouletteOutline(),
                  //     ),
                  //     Transform.scale(
                  //       scale: 1.3,
                  //       child: Roulette(
                  //         controller: menuRouletteController,
                  //         style: const RouletteStyle(
                  //             dividerColor: kColorSnowWhite,
                  //             centerStickerColor: kColorSnowWhite),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
                RuletaTextButton(
                  width: 200,
                  text: Strings.jugar,
                  onTap: () {
                    Navigator.pushNamed(context, '/player_selection');
                  },
                  color: kColorRed,
                  textStyle: const TextStyle(
                      fontFamily: 'LuckiestGuy',
                      fontSize: 40,
                      color: kColorSnowWhite,
                      height: 2),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // menuRouletteController.dispose();
    super.dispose();
  }
}
