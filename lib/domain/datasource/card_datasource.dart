import 'package:seven_wonders_alone/domain/entities/card.dart';

abstract class CardDatasource {
  Future<List<GenericCard>> getLeaderCards();
  Future<List<GenericCard>> getActionCards();
}
