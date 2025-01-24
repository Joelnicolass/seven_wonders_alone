import 'package:seven_wonders_alone/domain/entities/card.dart';
import 'package:seven_wonders_alone/domain/repositories/card_repository.dart';

class GetActionCardsUseCase {
  final CardRepository _cardRepository;
  GetActionCardsUseCase(this._cardRepository);

  Future<List<GenericCard>> execute() {
    return _cardRepository.getActionCards();
  }
}
