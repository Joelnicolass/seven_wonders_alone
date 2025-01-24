import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';

class Swiper extends StatelessWidget {
  final List<dynamic> cards;
  final dynamic Function() onInit;
  final void Function() onEnd;
  final bool Function(
      int prevIndex, int? currentIndex, CardSwiperDirection direction) onSwipe;
  final int numberOfCardsDisplayed;
  final Offset backCardOffset;
  final bool disableSwipe;

  const Swiper(
      {super.key,
      required this.cards,
      required this.onInit,
      required this.onEnd,
      required this.onSwipe,
      this.numberOfCardsDisplayed = 3,
      this.backCardOffset = const Offset(0, 0),
      this.disableSwipe = false});

  @override
  Widget build(BuildContext context) {
    onInit();
    return CardSwiper(
      isDisabled: disableSwipe,
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
