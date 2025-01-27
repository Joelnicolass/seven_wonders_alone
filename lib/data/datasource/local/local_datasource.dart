import 'package:seven_wonders_alone/constants/constants.dart';
import 'package:seven_wonders_alone/domain/datasource/card_datasource.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';

class CardLocalDatasourceImpl implements CardDatasource {
  @override
  Future<List<GenericCard>> getActionCards() {
    final List<GenericCard> actions = [];
    for (int i = 0; i < LENGHT_ACTION_CARDS; i++) {
      actions.add(GenericCard(
        id: i.toString(),
        name: 'Action $i',
        imageFront: 'assets/cards/images/action_${i + 1}.png',
        imageBack: 'assets/cards/images/action_dorsal.png',
        mode: CardMode.back,
      ));
    }
    return Future.value(actions);
  }

  @override
  Future<List<GenericCard>> getLeaderCards() {
    final List<GenericCard> leaders = [];
    for (int i = 0; i < LENGHT_LEAEDERS_CARDS; i++) {
      leaders.add(GenericCard(
        id: i.toString(),
        name: 'Leader $i',
        imageFront: 'assets/cards/images/leader_${i + 1}.png',
        imageBack: 'assets/cards/images/leader_dorsal.png',
        mode: CardMode.back,
      ));
    }
    return Future.value(leaders);
  }

  @override
  Future<List<GenericCard>> getActionBuildWonderCards() {
    final List<GenericCard> actions = [];
    for (int i = 0; i < LENGHT_ACTION_BUILD_WONDER_CARDS; i++) {
      actions.add(GenericCard(
        id: i.toString(),
        name: 'Action Build Wonder $i',
        imageFront: 'assets/cards/images/action_build_wonder_${i + 1}.png',
        imageBack: 'assets/cards/images/action_dorsal.png',
        mode: CardMode.back,
      ));
    }
    return Future.value(actions);
  }

  @override
  Future<List<GenericCard>> getActionSellCards() {
    final List<GenericCard> actions = [];
    for (int i = 0; i < LENGHT_ACTION_SELL_CARDS; i++) {
      actions.add(GenericCard(
        id: i.toString(),
        name: 'Action Sell $i',
        imageFront: 'assets/cards/images/action_sell_card_${i + 1}.png',
        imageBack: 'assets/cards/images/action_dorsal.png',
        mode: CardMode.back,
      ));
    }
    return Future.value(actions);
  }
}
