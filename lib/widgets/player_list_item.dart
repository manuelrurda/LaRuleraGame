import 'package:flutter/material.dart';
import 'package:la_ruleta/widgets/ruleta_text_button.dart';

import '../constants/colors.dart';

class PlayerListItem extends StatelessWidget {
  final String name;
  final VoidCallback onTapDelete;

  const PlayerListItem(
      {super.key, required this.name, required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
                color: kColorBlack,
                fontFamily: 'LuckiestGuy',
                fontSize: 30,
                height: 1.3),
          ),
        ),
        RuletaTextButton(
          width: 50,
          text: "x",
          onTap: onTapDelete,
          color: kColorRed,
          textStyle: const TextStyle(
              color: kColorBlack,
              fontFamily: 'LuckiestGuy',
              fontSize: 20,
              height: 1.3),
        )
      ],
    );
  }
}
