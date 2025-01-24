import 'package:flutter/material.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';

class ActionCard extends StatelessWidget {
  final GenericCard card;
  const ActionCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 4,
        ),
        image: DecorationImage(
          image: AssetImage(
              card.mode == CardMode.front ? card.imageFront : card.imageBack),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
