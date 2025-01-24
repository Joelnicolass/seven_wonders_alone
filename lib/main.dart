import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';
import 'package:seven_wonders_alone/presentation/components/action_card/action_card.dart';
import 'package:seven_wonders_alone/presentation/components/leader_card/leader_card.dart';
import 'package:seven_wonders_alone/presentation/components/swiper/swiper.dart';

const num LENGHT_LEAEDERS_CARDS = 5;
const num LENGHT_ACTION_CARDS = 12;

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
  @override
  Widget build(BuildContext context) {
    List<LeaderCard> generateLeaderCards() {
      List<LeaderCard> leaders = [];
      for (int i = 0; i < LENGHT_LEAEDERS_CARDS; i++) {
        leaders.add(LeaderCard(
            card: GenericCard(
          id: i.toString(),
          name: 'Leader $i',
          imageFront: 'assets/cards/images/leader_${i + 1}.png',
          imageBack: 'assets/cards/images/leader_dorsal.png',
          mode: CardMode.back,
        )));
      }
      return leaders;
    }

    List<ActionCard> generateActionCards() {
      List<ActionCard> actions = [];
      for (int i = 0; i < LENGHT_ACTION_CARDS; i++) {
        actions.add(ActionCard(
          card: GenericCard(
            id: i.toString(),
            name: 'Action $i',
            imageFront: 'assets/cards/images/action_${i + 1}.png',
            imageBack: 'assets/cards/images/action_dorsal.png',
            mode: CardMode.back,
          ),
        ));
      }
      return actions;
    }

    var leaderCards = <LeaderCard>[
      ...generateLeaderCards().map((leader) {
        if (leader.card.id == '0') {
          leader.card.mode = CardMode.front;
        }
        return leader;
      }),
    ];

    var actionCards = <ActionCard>[
      ...generateActionCards().map((action) {
        if (action.card.id == '0') {
          action.card.mode = CardMode.front;
        }
        return action;
      }),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Swiper(
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(0, 20),
                onEnd: () {},
                onSwipe: (prevIndex, currentIndex, direction) {
                  leaderCards[prevIndex].card.mode = CardMode.back;
                  leaderCards[currentIndex!].card.mode = CardMode.front;
                  return true;
                },
                cards: leaderCards,
              ),
            ),
            Flexible(
                child: Swiper(
              cards: actionCards,
              numberOfCardsDisplayed: 3,
              backCardOffset: const Offset(0, 20),
              onEnd: () {},
              onSwipe: (prevIndex, currentIndex, direction) {
                actionCards[prevIndex].card.mode = CardMode.back;
                actionCards[currentIndex!].card.mode = CardMode.front;
                return true;
              },
            ))
          ],
        ),
      ),
    );
  }
}
