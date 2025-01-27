import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seven_wonders_alone/data/datasource/local/local_datasource.dart';
import 'package:seven_wonders_alone/data/repositories/card_repository_impl.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';
import 'package:seven_wonders_alone/presentation/components/action_card/action_card.dart';
import 'package:seven_wonders_alone/presentation/components/leader_card/leader_card.dart';
import 'package:seven_wonders_alone/presentation/components/swiper/swiper.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seven Wonders Alone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          onPrimary: Color.fromARGB(255, 204, 188, 168),
        ),
      ),
      home: const MainView(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late List<LeaderCard> leaderCards = [];
  late List<ActionCard> actionCards = [];
  late List<ActionCard> actionBuildWonderCards = [];
  late List<ActionCard> actionSellCards = [];
  late List<ActionCard> originalActions = [];

  var isLeaderSelected = false;
  List<LeaderCard> leaderCardSelected = [];
  var canIABuildWonder = false;
  var canSellCards = false;
  var loading = true;

  @override
  void initState() {
    super.initState();

    getCardsData() async {
      final datasource = CardLocalDatasourceImpl();
      final repository = CardRepositoryImpl(datasource);
      final leaderCardsData = await repository.getLeaderCards();
      final actionCardsData = await repository.getActionCards();
      final actionBuildWonderCardsData =
          await repository.getActionBuildWonderCards();
      final actionSellCardsData = await repository.getActionSellCards();
      return {
        'leaderCardsData': leaderCardsData,
        'actionCardsData': [...actionCardsData, ...actionCardsData],
        'actionBuildWonderCardsData': actionBuildWonderCardsData,
        'actionSellCardsData': actionSellCardsData,
      };
    }

    getCardsData().then((value) {
      setState(() {
        leaderCards = value['leaderCardsData']!
            .map<LeaderCard>((card) => LeaderCard(card: card))
            .toList();
        actionCards = value['actionCardsData']!
            .map<ActionCard>((card) => ActionCard(card: card))
            .toList();
        actionBuildWonderCards = value['actionBuildWonderCardsData']!
            .map<ActionCard>((card) => ActionCard(card: card))
            .toList();
        actionSellCards = value['actionSellCardsData']!
            .map<ActionCard>((card) => ActionCard(card: card))
            .toList();
        originalActions = [...actionCards];
      });
    });

    delay() async {
      await Future.delayed(const Duration(seconds: 0));
    }

    delay().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  addActionBuildWonders() {
    if (canIABuildWonder) {
      actionCards.addAll(actionBuildWonderCards);
    }
  }

  addActionSellCards() {
    if (canSellCards) {
      actionCards.addAll(actionSellCards);
    }
  }

  shuffle<T>(List<T> list) {
    var random = Random();
    for (var i = list.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[n];
      list[n] = temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          if (loading) {
            return const FullScreenLoader(
              text: 'Cargando cartas...',
            );
          }

          return Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                  child: Swiper(
                    onInit: () {
                      if (!isLeaderSelected) {
                        shuffle(leaderCards);
                        leaderCards[0].card.mode = CardMode.front;
                      }
                    },
                    numberOfCardsDisplayed: isLeaderSelected ? 1 : 3,
                    backCardOffset: const Offset(0, 20),
                    onEnd: () {
                      shuffle(leaderCards);
                      leaderCards[0].card.mode = CardMode.front;
                    },
                    onSwipe: (prevIndex, currentIndex, direction) {
                      leaderCards[prevIndex].card.mode = CardMode.back;
                      leaderCards[currentIndex!].card.mode = CardMode.front;
                      return true;
                    },
                    cards: leaderCards,
                    disableSwipe: isLeaderSelected,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Boton seleccion de lider

              isLeaderSelected
                  ? Flexible(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2 -
                              MediaQuery.of(context).size.width * 0.7 / 2,
                        ),
                        child: Swiper(
                          onInit: () {
                            shuffle(actionCards);
                            //actionCards[0].card.mode = CardMode.front;
                          },
                          cards: actionCards,
                          numberOfCardsDisplayed: 3,
                          backCardOffset: const Offset(0, 20),
                          onEnd: () {
                            shuffle(actionCards);
                            actionCards[0].card.mode = CardMode.front;
                          },
                          onSwipe: (prevIndex, currentIndex, direction) {
                            actionCards[prevIndex].card.mode = CardMode.back;

                            actionCards[currentIndex!].card.mode =
                                CardMode.front;

                            if (actionCards[prevIndex].card.isUniqueUse) {
                              actionCards.removeAt(prevIndex);
                              var randomIndexOriginalAction =
                                  Random().nextInt(originalActions.length);
                              actionCards.add(
                                  originalActions[randomIndexOriginalAction]);

                              actionCards[prevIndex].card.mode = CardMode.back;
                              actionCards[currentIndex].card.mode =
                                  CardMode.front;
                            }

                            return true;
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Switch(
                                value: canIABuildWonder,
                                onChanged: (value) {
                                  setState(() {
                                    canIABuildWonder = value;
                                  });
                                },
                              ),
                              const Text('IA construye maravilla'),
                            ],
                          ),
                          Row(
                            children: [
                              Switch(
                                value: canSellCards,
                                onChanged: (value) {
                                  setState(() {
                                    canSellCards = value;
                                  });
                                },
                              ),
                              const Text('Vender cartas'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addActionBuildWonders();
                                  addActionSellCards();
                                  shuffle(actionCards);
                                  shuffle(actionCards);
                                  shuffle(actionCards);

                                  var currentCard = leaderCards.firstWhere(
                                      (element) =>
                                          element.card.mode == CardMode.front);
                                  leaderCardSelected.add(currentCard);
                                  isLeaderSelected = true;
                                });
                              },
                              child: const Text('Seleccionar Lider'),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              // Boton de finalizar

              isLeaderSelected
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLeaderSelected = false;
                            leaderCardSelected.forEach((element) {
                              element.card.mode = CardMode.back;
                            });
                            leaderCardSelected.clear();
                            actionCards.clear();
                            actionCards = [...originalActions];
                            canIABuildWonder = false;
                            canSellCards = false;
                            shuffle(leaderCards);
                            leaderCards[0].card.mode = CardMode.front;
                            shuffle(actionCards);
                            actionCards[0].card.mode = CardMode.front;
                          });
                        },
                        child: const Text('Finalizar'),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}

class FullScreenLoader extends StatelessWidget {
  final String text;

  const FullScreenLoader({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 204, 188, 168),
          ),
        ),
      ],
    );
  }
}
