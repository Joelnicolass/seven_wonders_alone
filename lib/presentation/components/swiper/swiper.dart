import 'dart:async';

import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';

class Swiper extends StatelessWidget {
  List<dynamic> cards;
  void Function() onEnd;
  bool Function(int prevIndex, int? currentIndex, CardSwiperDirection direction)
      onSwipe;
  int numberOfCardsDisplayed;
  Offset backCardOffset;

  Swiper(
      {super.key,
      required this.cards,
      required this.onEnd,
      required this.onSwipe,
      this.numberOfCardsDisplayed = 3,
      this.backCardOffset = const Offset(0, 0)});

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      numberOfCardsDisplayed: numberOfCardsDisplayed,
      backCardOffset: backCardOffset,
      onEnd: () => onEnd(),
      onSwipe: (previousIndex, currentIndex, direction) =>
          onSwipe(previousIndex, currentIndex, direction),
      cardsCount: cards.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          cards[index],
    );
  }
}
