import 'package:seven_wonders_alone/domain/entities/card.dart';
import 'package:seven_wonders_alone/domain/repositories/card_repository.dart';

class GetLeaderCardsUseCase {
  final CardRepository _cardRepository;
  GetLeaderCardsUseCase(this._cardRepository);

  Future<List<GenericCard>> execute() {
    return _cardRepository.getLeaderCards();
  }
}
