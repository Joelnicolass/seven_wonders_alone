import 'package:seven_wonders_alone/domain/datasource/card_datasource.dart';
import 'package:seven_wonders_alone/domain/entities/card.dart';
import 'package:seven_wonders_alone/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardDatasource _cardDatasource;
  CardRepositoryImpl(this._cardDatasource);

  @override
  Future<List<GenericCard>> getLeaderCards() {
    return _cardDatasource.getLeaderCards();
  }

  @override
  Future<List<GenericCard>> getActionCards() {
    return _cardDatasource.getActionCards();
  }
}
