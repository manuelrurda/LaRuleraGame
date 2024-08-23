import 'package:flutter/material.dart';
import 'package:la_ruleta/constants/colors.dart';
import 'package:la_ruleta/constants/styles.dart';
import 'package:la_ruleta/database/player_db.dart';
import 'package:la_ruleta/model/player.dart';
import 'package:la_ruleta/widgets/player_list_item.dart';
import 'package:la_ruleta/widgets/ruleta_text_button.dart';

import '../constants/strings.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  Future<List<Player>>? _playerList;
  final playerDB = PlayerDB();

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late bool _playButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchPlayers();
    updateButtonState();
  }

  void fetchPlayers() {
    setState(() {
      _playerList = playerDB.fetchAll();
    });
  }

  void updateButtonState() async {
    int count = await playerDB.count();
    setState(() {
      _playButtonEnabled = count > 1;
    });
  }

  void addPlayerListItem() async {
    if (_textEditingController.text.isNotEmpty) {
      await playerDB.create(name: _textEditingController.text);
      _textEditingController.clear();
      updateButtonState();
      fetchPlayers();
    }
  }

  void removePlayerListItem(int id) async {
    await playerDB.delete(id);
    updateButtonState();
    fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kColorYellow,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  children: <Widget>[
                    Text(
                      Strings.jugadores,
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
                      Strings.jugadores,
                      style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 60,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: kColorSnowWhite,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        )
                      ]),
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, top: 20, bottom: 40),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: FutureBuilder<List<Player>>(
                        future: _playerList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            final players = snapshot.data!;

                            return ListView.builder(
                                itemCount: players.length,
                                itemBuilder: (context, index) {
                                  final player = players[index];
                                  return PlayerListItem(
                                      name: player.name,
                                      onTapDelete: () {
                                        removePlayerListItem(player.id);
                                      });
                                });
                          }
                        },
                      )),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(15),
                                elevation: 5.0,
                                shadowColor: kColorGrey,
                                color: kColorLightGrey,
                                child: TextField(
                                  controller: _textEditingController,
                                  focusNode: _focusNode,
                                  onSubmitted: (value) {
                                    addPlayerListItem();
                                    _focusNode.requestFocus();
                                  },
                                  style: const TextStyle(
                                      fontFamily: 'LuckiestGuy',
                                      color: kColorBlack,
                                      fontSize: 22),
                                  keyboardType: TextInputType.text,
                                  decoration: kInputDecoration.copyWith(
                                      hintText: Strings.jugador1placeholder),
                                ),
                              ),
                            ),
                          ),
                          RuletaTextButton(
                            width: 70,
                            text: Strings.simboloSuma,
                            onTap: () {
                              addPlayerListItem();
                            },
                            color: kColorGreen,
                            textStyle: const TextStyle(
                              fontFamily: 'LuckiestGuy',
                              fontSize: 40,
                              color: kColorSnowWhite,
                              height: 1,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              RuletaTextButton(
                width: 200,
                text: Strings.jugar,
                onTap: () {
                  if (_playButtonEnabled) {
                    Navigator.pushNamed(context, '/roulette');
                  }
                },
                color: (_playButtonEnabled) ? kColorRed : kColorGrey,
                textStyle: const TextStyle(
                    fontFamily: 'LuckiestGuy',
                    fontSize: 40,
                    color: kColorSnowWhite,
                    height: 2),
              )
            ],
          ),
        )),
      ),
    );
  }
}
